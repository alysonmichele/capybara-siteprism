require 'spec_helper'

describe "Test" do
	it "should log in" do
		page.driver.browser.manage.window.maximize
		@login = LoginPage.new
		@login.load

		@login.login("#{$DT_PORTAL_USERNAME}", "#{$DT_PORTAL_PASSWORD}")
	end
end