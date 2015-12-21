current_path=File.expand_path("..", __FILE__)
f=File.join(current_path, 'support_classes.rb')
require f

class FindMe < SitePrism::Page
	include Helper
	set_url "/findme_main.php"

	elements :delete, 'img[alt="Delete"]'
	elements :table, '#findme_table.tablesorter tbody tr'

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

