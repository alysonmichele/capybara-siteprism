require 'spec_helper'

describe "Create A New FindMe list" do
	it "should log in and create a new find me list" do
		page.driver.browser.manage.window.maximize
		@login = Login.new
		@login.load

		@login.login("#{$DT_PORTAL_USERNAME}", "#{$DT_PORTAL_PASSWORD}")

		@fm = FindMe.new
		@fm.load

		@fm.create_findme
		@fm.fm_name("capy FM")
		@fm.fm_type
		@fm.fm_type
		@fm.fm_timeout
		@fm.fm_record
		@fm.fm_simultaneous_calls
		@fm.fm_advanced_audio_config
		@fm.fm_call_screening
		@fm.fm_add_number("8887778989")
		@fm.fm_loop_count
		@fm.fm_route_options
		@fm.fm_hold_music

		@fm.save
	end
end
describe "Delete A FindMe list" do
	it "should log in and delete a find me list" do
		page.driver.browser.manage.window.maximize
		@login = Login.new
		@login.load

		@login.login("#{$DT_PORTAL_USERNAME}", "#{$DT_PORTAL_PASSWORD}")

		@fm = FindMe.new
		@fm.load

		button = @fm.delete[0]

		button.click
		page.driver.browser.switch_to.alert.accept
	end
end