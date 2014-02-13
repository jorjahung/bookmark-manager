module SessionHelpers

	def sign_in(email, password)
		visit "/sessions/new"
		fill_in "email", :with => email
		fill_in "password", :with => password
		click_button "Sign in"
	end

	def sign_up(email = "alice@example.com",
  						password = "oranges!",
              password_confirmation = "oranges!")
	  visit '/users/new'
	  fill_in :email, :with => email
	  fill_in :password, :with => password
	  fill_in :password_confirmation, :with => password_confirmation
	  click_button "Sign up"
	end
	
	def reset_pw(email = "test@test.com")
	  fill_in :email, :with => email
	  click_button "Reset password"
	end

	def create_token(password_token="FAKETOKEN",
									password_token_timestamp = Time.now,
									token_url='/users/reset_password/FAKETOKEN')
		@user.update(:password_token => password_token,
								 :password_token_timestamp => password_token_timestamp)
		visit token_url
	end

	def new_pw(email="test@test.com",
						 password = "newpassword",
						 password_confirmation = "newpassword")
		fill_in :email, :with => email
	  fill_in :password, :with => password
	  fill_in :password_confirmation, :with => password_confirmation
	  click_button "Reset password"
	end

end