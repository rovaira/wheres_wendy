class PingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @ping = Ping.new
  end

  def create
    receiver = User.find(params["ping"]["receiver_id"])
    @ping = Ping.new(ping_params)

    @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]

    if @ping.save
      PingMailer.new_ping(@ping).deliver_later
      @client.messages.create(
        from: ENV["TWILIO_PHONE_NUMBER"],
        to: "+1#{receiver.phone}",
        body: %{
          Hello #{receiver.first_name}! #{@ping.sender.first_name} from the
          Class of #{@ping.sender.class_year} is nearby and says hello. Message
          back using their info below to say hi and keep the lamp burning!
          #{@ping.sender.phone}
          #{@ping.sender.email}
        }
      )
      flash[:notice] = "Successfully pinged #{receiver.first_name}."
      redirect_to user_path(receiver.id)
    else
      flash[:notice] = "Error pinging #{receiver.first_name}."
      redirect_to user_path(receiver.id)
    end
  end

  private

  def ping_params
    params.require(:ping).permit(:sender_id, :receiver_id)
  end

  # def text_body(ping)
  #   %{
  #     "Hello #{receiver.first_name}! #{ping.sender.first_name} from the Class
  #     of #{ping.sender.class_year} is nearby and says hello.
  #
  #     Message back using their information below to say hi and keep the
  #     lamp burning!
  #
  #     #{ping.sender.phone}
  #     #{ping.sender.email}
  #   }
  # end
end
