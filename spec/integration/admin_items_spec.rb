require "spec_helper"

describe "admin items control", type: :feature do

  describe "viewing the item listing" do

    it "an admin can see an item listing page" do
      mock_admin

      visit admin_items_path

      expect(page).to have_content("Items")
    end

    it "an admin can see all items" do
      mock_admin
      image = create(:image)
      item = create(:item, title: "A Pizza Pie", image_id: image.id)

      visit admin_items_path

      within(".manage-item-list") do
        expect(page).to have_content(item.title)
      end
    end
  end

  describe "creating an item" do

    it "shows a create button" do
      mock_admin

      visit admin_items_path

      expect(page).to have_link("New Item")
    end

    it "goes to the new item page when clicking New Item" do
      mock_admin

      visit admin_items_path

      click_link_or_button "New Item"

      expect(page).to have_content("Create New Item")
    end

    it "can create a new item" do
      mock_admin
      create(:category, name: "Pasta")

      visit admin_items_path
      click_link_or_button "New Item"
      fill_in_new_item
      click_link_or_button "Submit"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Lasagna")
      expect(page).to have_content("Steaming bowl of cheesy noodles")
      expect(page).to have_content("$8.00")
      expect(page).to have_content("Pasta")
    end
  end

  describe "editing an item" do
    it "can edit item attributes" do
      mock_admin
      create_item

      visit admin_items_path
      click_link_or_button "Edit"
      update_item_params
      click_link_or_button "Submit"

      expect(page).to have_content("Lasagna")
      expect(page).to have_content("Steaming bowl of cheesy noodles.")
      expect(page).to have_content("$8.00")
    end

    it "can edit category attributes" do
      create(:category, name: "Something")
      mock_admin
      create_item

      visit admin_items_path
      click_link_or_button "Edit"
      update_category_param
      click_link_or_button "Submit"

      expect(page).to have_content("Something")
    end

  end

  private

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(admin)
  end

  def update_item_params
    fill_in "item[title]",       with: "Lasagna"
    fill_in "item[description]", with: "Steaming bowl of cheesy noodles."
    fill_in "item[unit_price]",  with: 800
  end

  def update_category_param
    select  "Something", from: "item[categories][]"
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

  def create_item
    image = create(:image)
    item = create(:item, title: "milk",
                                     description: "some cheese stuff",
                                     image_id: image.id)
    category = create(:category)
    item.categories << category
  end
end
