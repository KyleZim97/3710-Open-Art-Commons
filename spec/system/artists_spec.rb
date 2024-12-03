require 'rails_helper'

RSpec.describe "Artists", type: :system do

  # happy path sign in
  context "new user with correct information" do
    it "signs up successfully" do

      visit new_artist_registration_path

      fill_in "Username", with: "Capybara"
      fill_in "About artist", with: "Capybara and test and so on"
      fill_in "Created", with: "2023-01-01" 
      fill_in "Email", with: "capybara@example.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"

      click_button "Sign up"

      expect(page).to have_content("You have signed up successfully")
    end
  end

  # sad path sign in
  context "new user with incorrect information" do
    it "error message displayed" do

      visit new_artist_registration_path

      fill_in "Username", with: "Capybara"
      fill_in "About artist", with: "Capybara and test and so on"
      fill_in "Created", with: "2023-01-01" 
      fill_in "Email", with: ""
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"

      click_button "Sign up"

      expect(page).to have_content("Email can't be blank")
    end
  end

  # search gallery testing Happy path
  context "Search function with valid search terms" do
    let!(:artist) { FactoryBot.create(:artist) }
    let!(:art1) { FactoryBot.create(:art, title: "Beautiful Sunset", tags: "Beautiful, Sunset", artist: artist) }
    let!(:art2) { FactoryBot.create(:art, title: "Modern Sculpture", tags: "Modern, Sculpture", artist: artist) }

    # Happy path
    it "displays results when a valid search term is entered" do
      visit root_path

      fill_in "Tags", with: "Sunset"
      click_button "Search"

      expect(page).to have_content("Beautiful Sunset")
      expect(page).not_to have_content("Modern Sculpture")
    end
  end

  # search gallery testing sad path
  context "Search function with valid search terms" do
    let!(:artist) { FactoryBot.create(:artist) }
    let!(:art1) { FactoryBot.create(:art, title: "Beautiful Sunset", tags: "Beautiful, Sunset", artist: artist) }
    let!(:art2) { FactoryBot.create(:art, title: "Modern Sculpture", tags: "Modern, Sculpture", artist: artist) }

    it "displays no images found message" do
      visit root_path

      fill_in "Tags", with: "Rock"
      click_button "Search"

      expect(page).to have_content("No images found")
    end
  end
end