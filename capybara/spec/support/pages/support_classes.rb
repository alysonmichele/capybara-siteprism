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



