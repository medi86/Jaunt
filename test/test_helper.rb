ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'phantomjs'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs: Phantomjs.path)
end

Capybara.current_driver = :poltergeist

class ActiveSupport::TestCase
  fixtures :all
  # Add more helper methods to be used by all tests here...
end
