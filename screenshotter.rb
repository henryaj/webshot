require 'capybara'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara::Screenshot.webkit_options = { width: 1024, height: 768 }

module Screenshotter
  def self.shoot(uri)
    puts "Taking screenshot..."
    session = Capybara::Session.new(:selenium)
    session.visit(uri)
    path = session.save_screenshot
    puts "Screenshot saved to #{path}."
    Capybara.reset_sessions!
  end
end
