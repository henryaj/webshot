require "rufus-scheduler"
require_relative "screenshotter"
require_relative "emailer"

required_env_vars = %w(INTERVAL WEBPAGE EMAIL MAILGUN_API_KEY MAILGUN_DOMAIN)
required_env_vars.each do |e|
  raise "All of #{required_env_vars} must be set in the environment." unless ENV[e]
end

scheduler = Rufus::Scheduler.new

puts "Taking screenshot every #{ENV["INTERVAL"]}."
scheduler.every ENV["INTERVAL"], first: :now do
  path = Screenshotter.shoot(ENV["WEBPAGE"])
  Emailer.send_to(path, ENV["EMAIL"])
end

puts "Starting scheduler..."
scheduler.join
