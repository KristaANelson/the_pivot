require "spec_helper"

describe "editing categories woo", type: :feature do

  describe "editing categories" do

    before(:each) do
      Category.create(name: "test_category")
      visit categories_path
    end

    it "starts with category in index" do
      expect(page).to have_content("test_category")
    end

    it "has an editing link" do
      expect(page).to have_link("Edit Category")
    end

    it "has an editing link that works" do
      first(:link, "Edit Category").click
      expect(page).to have_content("Edit Category")
    end

    it "edits categories" do
      first(:link, "Edit Category").click
      fill_in "category[name]", :with => "EDITED"
      click_link_or_button "Update Category"
      expect(page).to have_content("EDITED")
    end

  end

end


