require "spec_helper"

describe "the admin view", type: :feature do
  include Capybara::DSL

  #before(:each) do
    #user = User.find_by(role: 1)
    #mock(ApplicationController).stub!(:current_user).and_return(user)
    #visit admin_path
  #end

  describe "home page" do

    xit "shows an admin link on the homepage when admin logged in" do
      visit root_url
      within first(".navbar-nav") do
        expect(page).to have_link("Admin")
      end
    end

  end

  describe "admin dashboard" do

    it "exists" do
      visit admin_path
      within(".admin-title") do
        expect(page).to have_content("Admin Dashboard")
      end
    end
  end
end
