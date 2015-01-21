require "spec_helper"

describe "the guest view", type: :feature do
  include Capybara::DSL

  describe "the home page" do

    before(:each) do
      visit root_path
    end

    it "has a navbar" do
      within first(".navbar-nav") do
        expect(page).to have_link("Home")
        expect(page).to have_link("Menu")
      end

      within (".menu_right") do
        expect(page).to have_link("Login")
      end
    end

    it "has no link to admin login" do
      expect(page).not_to have_link("Admin")
    end

    it "goes to the menu page" do
      page.click_link("Menu")
      expect(current_path).to eq(menu_path)
    end
  end

  describe "the menu view" do

    before(:each) do
      visit menu_path
    end

    it "shows all the menu items" do
      expect(page).to have_content("some cheese stuff")
      expect(page).to have_content("milk")
    end

    it "has a side navbar for menu categories" do
      within(".sidebar-nav") do
        Category.all.each do |category|
          expect(page).to have_link(category.name)
        end
      end
    end

    xit "links to the correct menu categories" do
      category = "Drinks"
      page.click_link(category)
      expect(current_path).to eq(menu_path)
    end
  end

  describe "the cart view" do
    xit "exists" do
      visit cart_path
      expect(current_path).to eq(cart_path)
    end
  end
end
