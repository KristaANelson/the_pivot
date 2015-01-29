require "spec_helper"

describe "the admin view", type: feature do
  include Capybara::DSL

  describe "home page" do
    it "shows an admin link on the homepage when admin logged in" do
      admin = create(:admin, email: "test@test.com")
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit root_path

      expect(page).to have_link("Admin")
    end

  end

  describe "admin dashboard" do

    it "exists" do
      admin = create(:admin, email: "test@test.com")
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_path

      within(".admin-title") do
        expect(page).to have_content("Admin Dashboard")
      end

    end
  end
end
