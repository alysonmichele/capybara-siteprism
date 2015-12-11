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

	def wizard_next_page
		find(".js-next").click
	end

	def wizard_enable_pattern_match
		choose("pattern-yes")
	end

	def wizard_enable_schedule_routing
		choose("schedule-yes")
	end

	def wizard_expand_advanced_options
		if page.has_text?("Advanced options (show)")
			find('.js-show-advanced').click
		end
	end

	def wizard_enable_reverse_lookup
		choose("reverse-lookup-yes")
	end

	def wizard_enable_ring_for_caller
		choose("play-ring-yes")
	end

	def wizard_cycle_recording_settings
		select("Record after transfer", :from => "record-call")
		select("Record up to transfer", :from => "record-call")
		select("Record whole call", :from => "record-call")
	end

	def wizard_enable_phone_label(label)
		choose("phone-label-yes")
		find(".js-label-change-accept").click
		fill_in("phone_label", :with => "#{label}")
	end

	def wizard_enable_phone_suffix(suffix)
		fill_in("phone_suffix", :with => "#{suffix}")
	end

	def wizard_enable_lf_source
		choose("source-name-yes")
	end

	def wizard_set_pattern
		find(".js-add-pattern").click
		find("div#patterns-panel.routing-panel.js-pattern-panel ul.active-patterns.js-active-patterns li.js-active-pattern.active").click
	end

	def wizard_set_schedule
		within("#schedules-panel") do
			select("Do Not Delete", :from => "schedule-choices")
			select("No Schedule", :from => "schedule-choices")
		end
	end

	def wizard_route_read_text(text)
		fill_in "prompt", :with => "#{text}"
	end

	def wizard_route_IVR
		select("IVR", :from => "routing-type")
		page.has_text?("Then, Route to an IVR")
	end

	def wizard_cycle_pcas
		find(:xpath, "/html/body/div[3]/div[3]/div/div/div/div[1]/div/select").find("option[value='-1']").select_option
		find(:xpath, "/html/body/div[3]/div[3]/div/div/div/div[1]/div/select").find("option[value='0']").select_option
	end

	def wizard_enable_google_analytics
		choose("yes")
		find(:xpath, "/html/body/div[3]/div[3]/div/div/div/div[2]/div[2]/select").find("option[value='#{$GOOGLE_ANALYTICS_PCA_ID}']").select_option
	end

	def wizard_set_analytics_values
		fill_in "referrer", :with => "referrer"
		fill_in "content", :with => "content"
		fill_in "campaign", :with => "campaign"
		fill_in "term", :with => "term"
		fill_in "medium", :with => "medium"
	end

	def wizard_save
		find(".js-save").click
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
	include Helper
	set_url "/call-extension"

	element :add_campaign, "#CampaignToolbar-add"
	element :campaign_card, :xpath, "/html/body/div[1]/div[5]/div/div[2]/div[1]/div/div[4]/div[3]/div/div[1]/div[1]"
	element :campaign_search, :xpath, "/html/body/div[1]/div[5]/div/div[2]/div[1]/div/div[1]/input"
	element :account_in_dropdown, :xpath, "/html/body/div[3]/div[2]/div[1]/select/option[2]"
	element :account_dropdown, "select#select-account.js-select-account"
	element :campaign_in_dropdown, :xpath, "/html/body/div[3]/div[2]/div[2]/select/option[2]"
	element :add_campaign_dropdown, "select#select-campaign.js-select-campaign"
	element :save_campaign, "span#modal-save.btn"
	element :sync_message, "span.sync-message.js-sync-message"
	element :configure_ad, "span.adgroup-routing-summary-label.unconfigured.js-adgroup-routing-summary-label"
	element :configure_ads, "div.edit-adgroups-btn.js-edit-adgroups-btn"
	element :submit_search, :xpath, "/html/body/div[3]/div[3]/div/div/div/div[3]/div/div/div[4]/input"
	element :adgroup_call_count, "div.campaign-adgroup-list div.adgroup-list-container div.adgroups-container.js-adgroups-container div.adgroup.js-adgroup div div.adgroup-display div.adgroup-body div.adgroup-stats div.adgroup-calls div.adgroup-stats-title"
	element :read_text_prompt, "prompt"

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

	def cycle_radio_buttons
		choose("number-type-canadian")
		choose("number-type-true800")
		choose("number-type-tollfree")
		choose("number-type-local")
	end

	def set_state_and_area_code(state, area_code)
		find(:xpath, "/html/body/div[3]/div[3]/div/div/div/div[3]/div/div/div[4]/select[1]").find("option[value='#{state}']").select_option
		find(:xpath, "/html/body/div[3]/div[3]/div/div/div/div[3]/div/div/div[4]/select[2]").find("option[value='#{area_code}']").select_option
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
