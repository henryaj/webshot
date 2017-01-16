require 'capybara'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

class Screenshotter
  def self.shoot(uri)
    puts "Taking screenshot..."
    session = Capybara::Session.new(:poltergeist)
    session.visit(uri)
    path = session.save_screenshot
    puts "Screenshot saved to #{path}."
    Capybara.reset_sessions!
    return path
  end
end
