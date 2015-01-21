require "spec_helper"

describe "the admin view", type: :feature do
  # include Capybara::DSL

  before(:each) do
    user = User.find_by(:role, 1)
    mock(ApplicationController).stub!(:current_user).and_return(user)
  end

  describe "home page" do

    xit "shows an admin link on the homepage when admin logged in" do
      visit root_url
      within("#nav-bar") do
        expect(page).to have_link("Admin")
      end
    end

    xit "no admin link for unregistered or default users" do
      visit root_url
      within("#nav-bar") do
        expect(page).to_not have_link("Admin")
      end

      user = User.find_by(:role, 0)
      mock(ApplicationController).stub!(:current_user).and_return(user)
      visit root_url

      within("#nav-bar") do
        expect(page).to_not have_link("Admin")
      end
    end

  end

end
