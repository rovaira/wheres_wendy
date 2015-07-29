class PingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @ping = Ping.new
  end

  def create
    ping = Ping.new(ping_params)
    @ping = ping
    twilio_number = ENV["TWILIO_PHONE_NUMBER"]
    twilio_sid = ENV["TWILIO_ACCOUNT_SID"]
    twilio_token = ENV["TWILIO_AUTH_TOKEN"]
    lamp_image = "https://s3.amazonaws.com/wheres-wendy-production/static/lamp_text_larger.jpg"

    share_phone_hash = {
      from: twilio_number,
      to: to_number(ping),
      body: share_phone_body(ping),
      media_url: lamp_image
    }
    email_only_hash = {
      from: twilio_number,
      to: to_number(ping),
      body: email_only_body(ping),
      media_url: lamp_image
    }

    if ping.save
      PingMailer.new_ping(@ping).deliver_later
      if ping.receiver.phone
        @text = Twilio::REST::Client.new(twilio_sid, twilio_token)
        if ping.sender.share_phone == true
          @text.messages.create(share_phone_hash)
        else
          @text.messages.create(email_only_hash)
        end
      end
      flash[:notice] = "Successfully pinged #{ping.receiver.first_name}."
      redirect_to user_path(ping.receiver.id)
    else
      flash[:notice] = "Error pinging #{ping.receiver.first_name}."
      redirect_to user_path(ping.receiver.id)
    end
  end

  private

  def ping_params
    params.require(:ping).permit(:sender_id, :receiver_id)
  end

  def share_phone_body(ping)
    "Hello #{ping.receiver.first_name}! #{ping.sender.first_name} from the \
Class of #{ping.sender.class_year} is nearby and says hello. Message back \
using their info below to say hi and keep the lamp burning!
#{ping.sender.phone}
#{ping.sender.email}"
  end

  def email_only_body(ping)
    "Hello #{ping.receiver.first_name}! #{ping.sender.first_name} from the \
Class of #{ping.sender.class_year} is nearby and says hello. Message back \
using their info below to say hi and keep the lamp burning!
#{ping.sender.email}"
  end

  def to_number(ping)
    "+1#{ping.receiver.phone}"
  end
end
