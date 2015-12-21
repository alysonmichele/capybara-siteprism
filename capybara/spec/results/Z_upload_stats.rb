require "spec_helper"

describe "Upload results", :js => true do	
	it "should upload stats", :results do
		page.driver.browser.manage.window.maximize
		visit "https://app.klipfolio.com/login?url=%2Fdashboard"

		fill_in "f-username", :with => "alyson.marchetti@dialogtech.com"
		fill_in "f-password", :with => "Ifbyphone"

		click_button("Sign In")

		click_link("Library")
		page.has_text?("Klips")

		click_link("Capybara Results")
		page.has_text?("About this Klip")

		click_link("Rspec results NEW")

		page.has_text?("About this Data Source")
		click_link("Re-Upload Now")
		
		attach_file('dsfile', File.expand_path("../capybara/rspec_results.json"))

		page.has_no_text?("No file selected")
		click_link("Advanced File Settings")
		select "JSON", from: "data-format"
		click_button("Upload Now")

		page.has_text?("Verify")

		click_button("Done")

		page.has_text?("About this Data Source")

		click_link("My Dashboards")
		page.has_text?("Capybara Results")
		find(:xpath, "/html/body/div[2]/div[7]/div/div[2]/div/div[2]/div/div[2]/div[1]/div/div[1]").click
		find(:xpath, "/html/body/div[4]/div[2]").click
		find(:xpath, "/html/body/div[4]/div[2]/div/div[2]").click

		page.has_text?("Email")
		find(:xpath, "/html/body/div[11]/div[3]/div[2]/div/div[2]/div[2]/textarea").set "alyson.marchetti@dialogtech.com"
		click_button("Send Now")

end
end
