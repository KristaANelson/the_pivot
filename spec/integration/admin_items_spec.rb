require "spec_helper"

describe "admin items control", type: :feature do

  describe "viewing the item listing" do

    it "an admin can see an item listing page" do
      mock_admin
      visit items_path

      expect(page).to have_content("Items")
    end

    it "an admin can see all items" do
      mock_admin
      image = create(:image)
      item = create(:item, title: "A Pizza Pie", image_id: image.id)
      visit items_path

      within(".manage-item-list") do
        expect(page).to have_content(item.title)
      end
    end
  end

  describe "creating an item" do

    it "an admin sees a create button" do
      mock_admin
      visit items_path

      expect(page).to have_link("New Item")
    end

    it "goes to the new item page when clicking New Item" do
      mock_admin
      visit items_path

      click_link_or_button "New Item"

      expect(page).to have_content("Create New Item")
    end

    it "can create a new item" do
      mock_admin
      create(:category, name: "Pasta")
      visit items_path

      click_link_or_button "New Item"
      fill_in_new_item
      click_link_or_button "Create Item"

      expect(current_path).to eq(items_path)
      expect(page).to have_content("Lasagna")
      expect(page).to have_content("Steaming bowl of cheesy noodles")
      expect(page).to have_content("$8.00")
      expect(page).to have_content("Pasta")
    end
  end

  private

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(admin)
  end

  def fill_in_new_item
    fill_in "item[title]",       with: "Lasagna"
    fill_in "item[description]", with: "Steaming bowl of cheesy noodles."
    fill_in "item[unit_price]",  with: 800
    select  "Pasta",             from: "item[categories][]"
    attach_file "item[images][image]",
      "#{Rails.root}/spec/support/images/pizza_cat.jpg"
    fill_in "item[images][img_title]",       with: "Pizza Cat"
    fill_in "item[images][img_description]", with: "Pizza Cat Pic"
  end
end
