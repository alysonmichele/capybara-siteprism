require 'spec_helper'

describe "Add Call Extension Campaign" do
	it "should add a new call extension campaign" do
		page.driver.browser.manage.window.maximize
		@login = Login.new
		@login.load

		@login.login("#{$DT_PORTAL_USERNAME}", "#{$DT_PORTAL_PASSWORD}")

		@campaign = CallExtension.new
		@campaign.load

		@campaign.add_campaign.click

		@campaign.wait_for_account_dropdown
		@campaign.select_account_dropdown

		@campaign.wait_for_add_campaign_dropdown
		@campaign.select_campaign_dropdown

		@campaign.enable_call_only
		@campaign.save_campaign.click

		@campaign.has_campaign_search?
	end
end
describe "Configure Single AdGroup" do
	it "should configure a single adgroup within a campaign" do
		page.driver.browser.manage.window.maximize
		@login = Login.new
		@login.load

		@login.login("#{$DT_PORTAL_USERNAME}", "#{$DT_PORTAL_PASSWORD}")

		@campaign = CallExtension.new
		@campaign.load

		@campaign.campaign_card.click
		@campaign.has_sync_message?

		@campaign.wait_for_configure_ad
		@campaign.configure_ad.click

		@campaign.cycle_radio_buttons

		@campaign.set_state_and_area_code($SOURCETRAK_STATE, $SOURCETRAK_AREA_CODE)
		@campaign.submit_search.click

		page.has_text?("Your phone number will come from area code: 312")
		@campaign.wizard_next_page

		@campaign.wizard_route_read_text("rahh")
		@campaign.wizard_enable_pattern_match
		@campaign.wizard_enable_schedule_routing
		@campaign.wizard_expand_advanced_options
		@campaign.wizard_enable_reverse_lookup
		@campaign.wizard_enable_ring_for_caller
		@campaign.wizard_cycle_recording_settings
		@campaign.wizard_enable_phone_label("capy label")
		@campaign.wizard_enable_phone_suffix("123")
		@campaign.wizard_enable_lf_source
		@campaign.wizard_set_pattern
		@campaign.wizard_set_schedule
		@campaign.wizard_route_IVR
		@campaign.wizard_next_page

		@campaign.wizard_cycle_pcas
		@campaign.wizard_enable_google_analytics
		@campaign.wizard_set_analytics_values
		@campaign.wizard_next_page

		@campaign.wizard_save
		@campaign.wait_for_adgroup_call_count
	end
end
describe "Configure All AdGroups" do
	it "should configure an adgroup via the edit all ad groups button" do
		page.driver.browser.manage.window.maximize
		@login = Login.new
		@login.load

		@login.login("#{$DT_PORTAL_USERNAME}", "#{$DT_PORTAL_PASSWORD}")

		@campaign = CallExtension.new
		@campaign.load

		@campaign.campaign_card.click
		@campaign.has_sync_message?

		@campaign.wait_for_configure_ads
		@campaign.configure_ads.click

		@campaign.cycle_radio_buttons

		@campaign.set_state_and_area_code($SOURCETRAK_STATE, $SOURCETRAK_AREA_CODE)
		@campaign.submit_search.click

		page.has_text?("Your phone numbers will come from area code: 312")
		@campaign.wizard_next_page

		@campaign.wait_for_read_text_prompt
		@campaign.wizard_route_read_text("rahh")
		@campaign.wizard_expand_advanced_options
		@campaign.wizard_enable_reverse_lookup
		@campaign.wizard_enable_ring_for_caller
		@campaign.wizard_cycle_recording_settings
		@campaign.wizard_enable_phone_label("capy label")
		@campaign.wizard_enable_phone_suffix("123")
		@campaign.wizard_enable_lf_source
		@campaign.wizard_route_IVR
		@campaign.wizard_next_page

		@campaign.wizard_cycle_pcas
		@campaign.wizard_enable_google_analytics
		@campaign.wizard_set_analytics_values
		@campaign.wizard_next_page

		@campaign.wizard_save
		@campaign.wait_for_adgroup_call_count
	end
end

