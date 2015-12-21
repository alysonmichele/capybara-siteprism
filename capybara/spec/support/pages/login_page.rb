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
