require "mailgun-ruby"

class Emailer
  def self.send_to(path, email)
    mg = Mailgun::Client.new(ENV.fetch("MAILGUN_API_KEY"))
    message = Mailgun::MessageBuilder.new

    message.from("webshot@#{ENV.fetch("MAILGUN_DOMAIN")}")
    message.add_recipient(:to, email)
    message.subject("[webshot] Screenshot at #{Time.now}")
    message.body_text("Screenshot taken by webshot.")
    message.add_attachment(path, "screenshot.png")

    puts "Sending email..."
    result = mg.send_message(ENV.fetch("MAILGUN_DOMAIN"), message)
    p result
  end
end
