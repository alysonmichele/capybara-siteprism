require 'spec_helper'

describe "Create A New VM" do
	it "should create a new voicemail app" do
		page.driver.browser.manage.window.maximize
		@login = Login.new
		@login.load

		@login.login("#{$DT_PORTAL_USERNAME}", "#{$DT_PORTAL_PASSWORD}")

		@vm = Voicemail.new
		@vm.load