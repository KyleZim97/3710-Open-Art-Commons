require 'rails_helper'

RSpec.describe "Artists", type: :system do

  context "new user with correct information" do
    visit new_artist_session_path
      fill_in "username", with "Capybara"
      fill_in "about_artist", with "Capybara"
      fill_in "created", with "Capybara"
      fill_in "email", with "Capybara"
      fill_in "password", with "Capybara"
      fill_in "password_confirmation", with "Capybara"
      expect(page).to have_content("you have signed up successfully")

  pending "add some scenarios (or delete) #{__FILE__}"
end
