current_path=File.expand_path("..", __FILE__)
f=File.join(current_path, 'support_classes.rb')
require f

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
	element :adgroup_id, "div.adgroup-display div.adgroup-title.adgroup-type-color-configured span.adgroup-id"

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

	def unconfigure_adgroup_hover_click
		find(:xpath, "/html/body/div[1]/div[5]/div/div[2]/div[2]/div/div[3]/div/div[4]/div/div/div").hover
		find("html body div.div_main_wide div.bigcontentbox div#app-main div#app-content div#call-extension-edit-campaign.js-call-extension-edit-campaign div div.campaign-adgroup-list div.adgroup-list-container div.adgroups-container.js-adgroups-container div.adgroup.js-adgroup div div.adgroup-display div.adgroup-title.adgroup-type-color-configured span.adgroup-unconfigure-btn.js-adgroup-unconfigure-btn").click
	end

	def unconfigure_adgroup
		find(:xpath, "/html/body/div[1]/div[5]/div/div[2]/div[2]/div/div[3]/div/div[4]/div/div/div/div[2]/span[1]", wait: 5).click
	end

end	

