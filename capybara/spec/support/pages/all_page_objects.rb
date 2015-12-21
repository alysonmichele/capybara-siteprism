require 'spec_helper'
require 'capybara'
require 'capybara/rspec'
require 'site_prism'

current_path=File.expand_path("..", __FILE__)
Dir.glob(File.join(current_path, '**', '*.rb')).each do |f|
	require f
end

