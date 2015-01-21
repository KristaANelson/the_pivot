require "spec_helper"

describe "the guest view", type: :feature do
  # include Capybara::DSL

  describe "the home page" do
    xit "has a navbar" do
      visit root_url
      within("#nav-bar") do
        expect(page).to have_link("Main")
        expect(page).to have_link("Menu")
        expect(page).to have_link("Login")
      end
    end

    xit "has no link to admin login" do
      visit root_url
      expect(page).not_to have_link("Admin")
    end

    xit "goes to the menu page" do
      page.click_link("Menu")
      expect(current_path).to eq(menu_path)
    end
  end

  describe "the menu view" do
    xit "shows all the menu items" do
      visit(menu_path)
      expect(page).to have_content("some cheese stuff")
      expect(page).to have_content("milk")
    end

    xit "has an inner navbar for menu categories" do
      visit(menu_path)
      within("#nav-bar2") do
        Category.all.each do |category|
          expect(page).to have_link(category.name)
        end
      end
    end

    xit "links to the correct menu categories" do
      visit(menu_path)
      page.click_link("Main meals")
      expect(current_path).to eq(menu_path(category))
    end
  end

  describe "the category menu view" do
    xit "shows only the category menu items" do
      visit(menu_path(1))
      expect(page).to have_content("some cheese stuff")
      expect(page).not_to have_content("milk")
    end

    xit "links to each item description" do
      category = Category.all.first
      item = category.items.first
      visit(menu_path(category.id))
      page.click_link(item.title)
      expect(current_path).to eq(item_path(item.id))
    end
  end

  describe "the cart view" do
    xit "exists" do
      visit cart_path
      expect(current_path).to eq(cart_path)
    end
  end
end
