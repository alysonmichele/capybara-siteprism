require 'spec_helper'
require 'capybara'
require 'capybara/rspec'
require 'site_prism'

class LoginPage < SitePrism::Page
	set_url "/login.php"

	element :username_field, "input[name='username']"
	element :password_field, "input[name='pin']"

	def login(user, pass)
		username_field.set(user)
		password_field.set(pass)
		click_button("Log In")
	end
end