unless ENV['DT_ENV']
  raise 'You must set the DT_ENV environment variable to run tests.  See README.md for more info.'
end

puts "Executing in DialogTech '#{ENV['DT_ENV'].upcase}' environment."

require File.expand_path('./dt_env/'+ENV['DT_ENV']+'.rb', File.dirname(__FILE__))

Capybara.configure do |config|
  config.app_host   = $DT_PORTAL_SECURE_BASE_URL
  config.run_server = false
end

puts "Portal URL: #{Capybara.app_host}"