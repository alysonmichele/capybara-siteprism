require 'spec_helper'

describe "Create A New VM" do
	it "should log in and create a new voicemail app" do
		page.driver.browser.manage.window.maximize
		@login = Login.new
		@login.load

		@login.login("#{$DT_PORTAL_USERNAME}", "#{$DT_PORTAL_PASSWORD}")

		@vm = Voicemail.new
		@vm.load

		@vm.create_voicemail
		@vm.vm_name("capy VM")
		@vm.vm_expiry("12/31/2015 00:00")
		@vm.vm_pin("0000")
		@vm.check_read_envelope
		@vm.check_send_email
		@vm.vm_email_address("#{$DT_EMAIL_ADDRESS}")
		@vm.vm_cycle_transcriptions
		@vm.vm_select_gender
		@vm.vm_select_language

		@vm.save

	end
end