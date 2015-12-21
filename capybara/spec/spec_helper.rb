ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require File.expand_path('../config/dt_env.rb', File.dirname(__FILE__))
require 'rspec/rails'
require 'capybara'
require 'capybara/rspec'
require 'site_prism'

#require_relative 'support/pages/support_classes.rb'
require_relative 'support/pages/all_page_objects.rb'

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 20

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include Capybara::DSL
end