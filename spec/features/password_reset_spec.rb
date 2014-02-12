require_relative 'helpers/session'

include SessionHelpers

feature "User can reset password" do

	before(:each) do
		User.create(:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
	end

	scenario "with email that is registered" do
		visit '/users/forgotten_password'
		fill_in "email", :with => "test@test.com"
		click_button "Reset password"
		expect(page).to have_content("Email sent!")
	end

	scenario "with email that is registered" do
		visit '/users/forgotten_password'
		fill_in "email", :with => "fail@test.com"
		click_button "Reset password"
		expect(page).to have_content("Email is not registered")
	end

end