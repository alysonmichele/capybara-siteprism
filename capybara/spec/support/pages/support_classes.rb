require 'spec_helper'
require 'capybara'
require 'capybara/rspec'
require 'site_prism'

module Helper
	def save
		click_button("Save")
	end

	def dismiss_alert
		page.driver.browser.switch_to.alert.accept
	end
end

class Login < SitePrism::Page
	set_url "/login.php"

	element :username_field, "input[name='username']"
	element :password_field, "input[name='pin']"

	def login(user, pass)
		username_field.set(user)
		password_field.set(pass)
		click_button("Log In")
	end
end

class Voicemail < SitePrism::Page
	include Helper
	set_url "/vmail_main.php"
	elements :touch_voicemail, "table#vmail_table.tablesorter tbody tr.alternateRow2 td a img"


	def create_voicemail
		click_link("Create a new Voice Mail Box")
	end

	def vm_name(name)
		fill_in "mailbox_identifier", :with => "#{name}"
	end

	def vm_expiry(expiry)
		fill_in "vmail_vacation_expiration", :with => "#{expiry}"
	end

	def vm_pin(pin)
		fill_in "pin", :with => "#{pin}"
	end

	def check_read_envelope
		check("vmail_envelope")
	end

	def check_send_email
		check("vmail_send_email")
	end

	def vm_email_address(email)
		fill_in "email_address", :with => "#{email}"
	end

	def vm_cycle_transcriptions
		select "Standard (automated @ $0.045/30sec)", from: "transcription_setting"
		select "Send Audio Email, then Text Email", from: "transcription_email"
	end

	def vm_select_gender
		select "Female", from: "gender"
	end

	def vm_select_language
		select "Spanish", from: "ref_language_id"
	end

end