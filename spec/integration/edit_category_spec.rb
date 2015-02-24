require "spec_helper"

describe "editing categories woo", type: :feature do

  describe "editing categories" do

    it "starts with category in index" do
      category = create(:category)
      user = create(:admin)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
                                                  and_return(user)

      visit admin_categories_path

      expect(page).to have_content(category.name)
    end

    it "has an editing link" do
      create(:category)
      user = create(:admin)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
                                                  and_return(user)

      visit admin_categories_path

      expect(page).to have_link("Edit")
    end

    it "has an editing link that works" do
      category = create(:category)
      user = create(:admin)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
                                                  and_return(user)

      visit admin_categories_path
      first(:link, "Edit").click

      expect(page).to have_content(category.name)
    end

    it "edits categories" do
      create(:category)
      user = create(:admin)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
                                                  and_return(user)

      visit admin_categories_path
      first(:link, "Edit").click
      fill_in "category[name]", with: "EDITED"
      click_link_or_button "Update Category"

      expect(page).to have_content("EDITED")
    end
  end
end
