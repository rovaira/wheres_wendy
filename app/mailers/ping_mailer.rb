class PingMailer < ApplicationMailer
  def new_ping(ping)
    @ping = ping

    mail(
      to: ping.receiver.email,
      subject: "#{ping.sender.first_name} says hi!"
    )
  end
end
