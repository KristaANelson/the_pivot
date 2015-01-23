require "spec_helper"

describe "the guest view", type: :feature do
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
        expect(page).to have_link("Cart")
      end
    end

    it "has no link to admin login" do
      expect(page).not_to have_link("Admin")
    end

    it "goes to the menu page" do
      page.click_link("Menu")
      expect(current_path).to eq(menu_path)
    end

    it "has a cart link" do
      within (".menu_right") do
        expect(page).to have_link("Cart")
      end
    end
  end

  describe "the menu view" do
    it "shows all the menu items" do
      item = FactoryGirl.create(:item, title: "milk", description: "some cheese stuff")
      category = FactoryGirl.create(:category)
      item.categories << category

      visit menu_path

      expect(page).to have_content("some cheese stuff")
      expect(page).to have_content("milk")
    end

    it "has a side navbar for menu categories" do
      visit menu_path

      within(".sidebar-nav") do
        Category.all.each do |category|
          expect(page).to have_link(category.name)
        end
      end
    end

    it "links to the correct menu categories" do
      FactoryGirl.create(:category, name: "Salads")

      visit menu_path
      page.click_link("Salads")

      expect(current_path).to eq(menu_path)
    end

    it "has add-to-cart links for each item" do
      item = FactoryGirl.create(:item, title: "milk", description: "some cheese stuff")
      category = FactoryGirl.create(:category)
      item.categories << category

      visit menu_path

      within first(".item-box") do
        expect(page).to have_button("Add to cart")
      end
    end
  end
end
