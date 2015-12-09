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