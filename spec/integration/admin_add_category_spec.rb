require "spec_helper"

describe "admin adding cateogries", type: :feature do

  describe "the category list page" do

    it "has a category in there" do
      user = create(:admin)
      create(:category)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
                                                  and_return(user)

      visit categories_path

      expect(page).to have_link("Create Category")
    end
  end

  describe "the category add page" do

    it "has a category add page" do
      user = create(:admin)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
        and_return(user)

      visit new_category_path

      expect(page).to have_content("Create New Category")
    end

    it "can add a category" do
      user = create(:admin)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit new_category_path
      fill_in "category[name]", with: "NEW CATEGORY"
      click_link_or_button ("Create Category")

      expect(page).to have_content("NEW CATEGORY")
    end

    it "redirects to categories page when done" do
      user = create(:admin)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit new_category_path
      fill_in "category[name]", with: "NEW CATEGORY"
      click_link_or_button ("Create Category")

      expect(current_path).to eq(categories_path)
    end

  end

end

