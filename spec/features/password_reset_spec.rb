require_relative 'helpers/session'

include SessionHelpers


feature "User reset password" do

	before(:each) do
		@user = User.create(:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
			visit '/users/reset_password'
	end

	scenario "should work with email that is registered" do
		reset_pw
		expect(page).to have_content("Email sent!")
	end

	scenario "not work with email that is not registered" do
		reset_pw("fail@test.com")
		expect(page).to have_content("Email address is not registered")
	end

	scenario "with working token" do
		fill_in "email", :with => "test@test.com"
		click_button "Reset password"
		@user.update(:password_token => "FAKETOKEN",
								 :password_token_timestamp => Time.now)
		visit '/users/reset_password/FAKETOKEN'
		expect(page).to have_content("New password")
	end

	scenario "should not work with fake token" do
		fill_in "email", :with => "test@test.com"
		click_button "Reset password"
		@user.update(:password_token => "FAKETOKEN",
								 :password_token_timestamp => Time.now)
		visit '/users/reset_password/FAILTOKEN'
		expect(page).to have_content("Failed to find password reset token")
	end

	scenario "should not work with expired token" do
		fill_in "email", :with => "test@test.com"
		click_button "Reset password"
		@user.update(:password_token => "FAKETOKEN",
								 :password_token_timestamp => "2014-02-13 09:24:52 +0000")
		visit '/users/reset_password/FAKETOKEN'
		expect(page).to have_content("Password reset token expired")
	end
 	
 	scenario "should double check that email and token combination is correct" do
		fill_in "email", :with => "test@test.com"
		click_button "Reset password"
		@user.update(:password_token => "FAKETOKEN",
								 :password_token_timestamp => Time.now)
		visit '/users/reset_password/FAKETOKEN'
		fill_in "email", :with => "fail@test.com"
		fill_in "password", :with => "newpassword"
		fill_in "password_confirmation", :with => "newpassword"
		click_button "Reset password"
		expect(page).to have_content("Failed to find email and reset token combination")
	end

 	scenario "and sign in after new password should work" do
		fill_in "email", :with => "test@test.com"
		click_button "Reset password"
		@user.update(:password_token => "FAKETOKEN",
								 :password_token_timestamp => Time.now)
		visit '/users/reset_password/FAKETOKEN'
		fill_in "email", :with => "test@test.com"
		fill_in "password", :with => "newpassword"
		fill_in "password_confirmation", :with => "newpassword"
		click_button "Reset password"
		sign_in("test@test.com", "newpassword")
		expect(page).to have_content("Welcome, test@test.com")
	end



end