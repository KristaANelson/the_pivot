require "spec_helper"

describe "admin authorization", type: :feature do
  include Capybara::DSL

  describe "admin login" do
    it "allows a user to log in as an admin and go to the dashboard" do
      create(:admin)

      visit root_url
      click_link("Login")
      fill_in "session[email]", :with => "admin@admin.com"
      fill_in "session[password]", :with => "password"
      click_button("Log in")
      expect(page).to have_content("Admin Dashboard")
    end

  end




end

