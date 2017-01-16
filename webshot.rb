require "rufus-scheduler"
require_relative "screenshotter"

required_env_vars = %w(INTERVAL WEBPAGE EMAIL)
required_env_vars.each do |e|
  raise "All of #{required_env_vars} must be set in the environment." unless ENV[e]
end

scheduler = Rufus::Scheduler.new

puts "Taking screenshot every #{ENV["INTERVAL"]}."
scheduler.every ENV["INTERVAL"], first: :now do
  Screenshotter.shoot(ENV["WEBPAGE"])
end

puts "Starting scheduler..."
scheduler.join
