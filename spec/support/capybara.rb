require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

RSpec.configure do |config|
  Capybara.default_driver = :poltergeist
end
