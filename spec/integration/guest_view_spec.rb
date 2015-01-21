require 'spec_helper'

describe 'the guest view', type: :feature do
  #include Capybara::DSL

  describe 'the home page' do
    xit "has a navbar" do
      visit root_url
      within("#nav-bar") do
        expect(page).to have_link("Main")
        expect(page).to have_link("Menu")
        expect(page).to have_link("Login")
      end
    end
  end
end
