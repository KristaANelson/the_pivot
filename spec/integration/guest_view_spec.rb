require 'rails_helper'

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

    xit "goes to the menu page" do
      page.click_link("Menu")
      expect(current_path).to eq(menu_path)
    end

    it 'adds a new phone number' do
      page.click_link("Add phone number")
      page.fill_in("Number", with: "555-9999")
      page.click_button("Create Phone number")
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content("555-9999")
    end


  end

  describe 'the menu view' do
    xit "shows all the menu items" do
      visit(menu_path)
      expect(page).to have_content("some cheese stuff")
      expect(page).to have_content("milk")
    end

    xit "has an inner navbar for menu categories" do
      visit(menu_path)
      within("#nav-bar2") do
        expect(page).to have_link("Main meals")
        expect(page).to have_link("Pizzas")
        expect(page).to have_link("Drinks")
        expect(page).to have_link("Salads")
        expect(page).to have_link("Desserts")
        expect(page).to have_link("Vegetarian Items")
      end
    end

    xit "links to the correct menu categories" do
      visit(menu_path)
      page.click_link("Main meals")
      expect(current_path).to eq(menu_path(category))
    end
  end

  describe 'the category menu view' do
    xit "shows only the category menu items" do
      visit(menu_path(1))
      expect(page).to have_content("some cheese stuff")
      expect(page).not to_have_content("milk")
    end

    xit "links to each item description" do
      visit(menu_path(1))
      page.click_link("pizza")
      expect(current_path).to eq(item_path(1))
    end
  end
end
