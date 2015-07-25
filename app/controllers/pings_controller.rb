class PingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @ping = Ping.new
  end

  def create
    receiver = User.find(params["ping"]["receiver_id"])
    @ping = Ping.new(ping_params)
    if @ping.save
      PingMailer.new_ping(@ping).deliver_later
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
end
