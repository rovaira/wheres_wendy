class PingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @ping = Ping.new
  end

  def create
    ping = Ping.new(ping_params)
    lamp_image = "https://s3.amazonaws.com/wheres-wendy-production/static/lamp_text_larger.jpg"

    share_phone_hash = {
      from: ENV["TWILIO_PHONE_NUMBER"],
      to: to_number(ping),
      body: share_phone_body(ping),
      media_url: lamp_image
    }

    email_only_hash = {
      from: ENV["TWILIO_PHONE_NUMBER"],
      to: to_number(ping),
      body: email_only_body(ping),
      media_url: lamp_image
    }

    if @ping.save
      PingMailer.new_ping(@ping).deliver_later
      if receiver.phone
        @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
        if @ping.sender.share_phone == true
          @client.messages.create(share_phone_hash)
        else
          @client.messages.create(email_only_hash)
        end
      end
      flash[:notice] = "Successfully pinged #{receiver.first_name}."
      redirect_to user_path(receiver.id)
    else
      flash[:notice] = "Error pinging #{receiver.first_name}."
      redirect_to user_path(receiver.id)
    end
  end

#   def create
#     receiver = User.find(params["ping"]["receiver_id"])
#     @ping = Ping.new(ping_params)
#
#     to_number = "+1#{receiver.phone}"
#     share_phone_body = %{
# Hello #{receiver.first_name}! #{@ping.sender.first_name} from
# the Class of #{@ping.sender.class_year} is nearby and says hello. Message
# back using their info below to say hi and keep the lamp burning!
# #{@ping.sender.phone}
# #{@ping.sender.email}
#   }
#     email_only_body = %{
# Hello #{receiver.first_name}! #{@ping.sender.first_name} from
# the Class of #{@ping.sender.class_year} is nearby and says hello. Message
# back using their info below to say hi and keep the lamp burning!
# #{@ping.sender.email}
#   }
#     lamp_image = "https://s3.amazonaws.com/wheres-wendy-production/static/lamp_text_larger.jpg"
#
#     share_phone_hash = {
#       from: ENV["TWILIO_PHONE_NUMBER"],
#       to: to_number,
#       body: share_phone_body,
#       media_url: lamp_image
#     }
#
#     email_only_hash = {
#       from: ENV["TWILIO_PHONE_NUMBER"],
#       to: to_number,
#       body: email_only_body,
#       media_url: lamp_image
#     }
#
#     if @ping.save
#       PingMailer.new_ping(@ping).deliver_later
#       if receiver.phone
#         @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
#         if @ping.sender.share_phone == true
#           @client.messages.create(share_phone_hash)
#         else
#           @client.messages.create(email_only_hash)
#         end
#       end
#       flash[:notice] = "Successfully pinged #{receiver.first_name}."
#       redirect_to user_path(receiver.id)
#     else
#       flash[:notice] = "Error pinging #{receiver.first_name}."
#       redirect_to user_path(receiver.id)
#     end
#   end

  private

  def ping_params
    params.require(:ping).permit(:sender_id, :receiver_id)
  end

  def share_phone_body(ping)
    %{
      Hello #{ping.receiver.first_name}! #{ping.sender.first_name} from
      the Class of #{ping.sender.class_year} is nearby and says hello. Message
      back using their info below to say hi and keep the lamp burning!
      #{ping.sender.phone}
      #{ping.sender.email}
    }
  end

  def email_only_body(ping)
    %{
Hello #{ping.receiver.first_name}! #{ping.sender.first_name} from
the Class of #{ping.sender.class_year} is nearby and says hello. Message
back using their info below to say hi and keep the lamp burning!
#{ping.sender.email}
  }
end

  def to_number(ping)
    "+1#{ping.receiver.phone}"
  end
end
