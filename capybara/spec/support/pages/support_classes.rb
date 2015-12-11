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

class CallExtension < SitePrism::Page
	set_url "/call-extension"

	element :add_campaign, "#CampaignToolbar-add"
	element :campaign_card, ""
	element :campaign_search, :xpath, "/html/body/div[1]/div[5]/div/div[2]/div[1]/div/div[1]/input"
	element :account_in_dropdown, :xpath, "/html/body/div[3]/div[2]/div[1]/select/option[2]"
	element :account_dropdown, "select#select-account.js-select-account"
	element :campaign_in_dropdown, :xpath, "/html/body/div[3]/div[2]/div[2]/select/option[2]"
	element :add_campaign_dropdown, "select#select-campaign.js-select-campaign"
	element :save_campaign, "span#modal-save.btn"

	def enable_call_only
		choose("call-only-flag-on")
	end

	def select_account_dropdown
		adwords_account = find(:xpath, "/html/body/div[3]/div[2]/div[1]/select/option[2]").text
		select adwords_account, :from => "select-account"
	end

	def select_campaign_dropdown
		adwords_campaign = find(:xpath, "/html/body/div[3]/div[2]/div[2]/select/option[2]").text
		select adwords_campaign, :from => "select-campaign"
	end
end	

class FindMe < SitePrism::Page
	include Helper
	set_url "/findme_main.php"

	elements :delete, 'img[alt="Delete"]'

	def create_findme
		click_link("Create a new Find Me list")
	end

	def fm_name(name)
		fill_in "listname", :with => "#{name}"
	end

	def fm_type
		select("Customer Service Hunt Group", :from => "listtype")
		select("Individual Find Me", :from => "listtype")
		select("Randomize Order", :from => "listorder")
		select("Round-Robin Order", :from => "listorder")
		select("Use the Order Shown At Right", :from => "listorder")
	end

	def fm_timeout
		select("50", :from => "timeout")
		select("40", :from => "timeout")
		select("30", :from => "timeout")
		select("20", :from => "timeout")
	end

	def fm_record
		check("record")
		uncheck("record")
	end

	def fm_simultaneous_calls
		select("3", :from => "simultaneous")
		select("2", :from => "simultaneous")
		select("1", :from => "simultaneous")
	end

	def fm_advanced_audio_config
		select("Use Default", :from => "usr_audio_prompt_set_id")
	end

	def fm_call_screening
		select("No Screening", :from => "screen_method")
		select("Whisper Audio", :from => "screen_method")
		check("whisper_incoming_phone_label")
		select("Whisper Text", :from => "screen_method")
		fill_in "whisper_phrase", :with => "capybara whisper"
		select("Record Caller's Name", :from => "screen_method")
		select("Last number tried without screening", :from => "auto_accept")
		select("Last number tried with screening", :from => "auto_accept")
		select("First answered call", :from => "auto_accept")
		select("Disabled", :from => "auto_accept")
		check("dtmf_only")
		uncheck("dtmf_only")
	end

	def fm_add_number(number)
		find("a", :text=> "Add Phone Number").click
		find(:xpath, "/html/body/div[1]/div[5]/div/form/ul[2]/li[1]/div[1]/table/tbody/tr/td[2]/div/input[2]").set "#{number}"
		click_button("Add")
	end

	def fm_loop_count
		select("5", :from => "loopcount")
		select("4", :from => "loopcount")
		select("3", :from => "loopcount")
		select("2", :from => "loopcount")
		select("1", :from => "loopcount")
	end

	def fm_route_options
		select("Route to an IVR", :from => "ref_findme_action_id")
		select("Do Not Delete", :from => "findme_action_parameter")
		select("Route to a different Find Me List", :from => "ref_findme_action_id")
		select("Route to a Virtual Receptionist", :from => "ref_findme_action_id")
		select("Do Not Delete", :from => "findme_action_parameter")
		select("Route to Voice Mail", :from => "ref_findme_action_id")
		select("Tell user no one is available and disconnect", :from => "ref_findme_action_id")
	end

	def fm_hold_music
		select("Use Default", :from => "holdmusic")
		select("Repeat continuously between attempts", :from => "holdrepeat")
		select("Only once between attempts", :from => "holdrepeat")
		select("Only once per Find Me session", :from => "holdrepeat")
	end

end
