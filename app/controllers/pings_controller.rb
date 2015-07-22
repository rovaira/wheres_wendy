class PingsController < ApplicationController
  def new
    @ping = Ping.new
  end

  def create
    # user = User.find(params["receiver_id"])
    binding.pry
    receiver = current_user
    @ping = Ping.new(ping_params)
    if @ping.save
      redirect_to @ping,
        notice: "Successfully pinged #{user.first_name}."
    else
      render :action => 'new'
    end
  end

  private

  def ping_params
    params.require(:ping).permit(:sender_id, :receiver_id)
  end
end
