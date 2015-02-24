require "spec_helper"

describe "admin Users Listing", type: :feature do

  describe "viewing the user listing" do

    it "an admin can see all users" do
      mock_admin
      user = create(:user)
      visit admin_users_path
      expect(page).to have_content("Users")
      expect(page).to have_content(user.full_name)
    end

    it "an admin can see a user's listing" do
      mock_admin
      user = create(:user)
      event = create(:event)
      item = create(:item, unit_price: 59, user_id: user.id, event_id: event.id)
      visit admin_users_path
      expect(page).to have_content("Users")
      expect(page).to have_content(user.full_name)
      expect(page).to have_content("Listings")
      visit admin_show_user_path(user)
      expect(page).to have_content(item.unit_price)
    end
  end

  describe "freeze and unfreeze a user account" do

    it "an admin can freeze a user accout" do
      mock_admin
      user = create(:user)
      visit admin_users_path
      expect(page).to have_content("Users")
      expect(page).to have_content(user.full_name)
      expect(page).to have_content("Freeze")
    end

    xit "an admin can unfreeze a user accout" do
      mock_admin
      user = create(:user)
      visit admin_users_path
      expect(page).to have_content("Users")
      expect(page).to have_content(user.full_name)
      expect(page).to have_content("unfreeze")
    end
  end


  describe "creating an item" do

    xit "shows a create button" do
      mock_admin

      visit admin_items_path

      expect(page).to have_link("Create")
    end

    xit "goes to the new item page when clicking New Item" do
      mock_admin

      visit admin_items_path
      click_link_or_button "New Item"

      expect(page).to have_content("Create New Item")
    end

    xit "can create a new item" do
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

    xit "gets a default image" do
      mock_admin
      create(:category, name: "Pasta")
      create(:image, title: "Missing")

      visit admin_items_path
      click_link_or_button "New Item"
      fill_in_new_item_without_image
      click_link_or_button "Submit"

      expect(page).to have_css('img[alt="Heart pizza"]')
    end
  end

  describe "editing an item" do
    xit "can edit item attributes" do
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

    xit "can edit category attributes" do
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
    select "Something", from: "item[categories][]"
  end

  def fill_in_new_item
    fill_in "item[title]",       with: "Lasagna"
    fill_in "item[description]", with: "Steaming bowl of cheesy noodles."
    fill_in "item[unit_price]",  with: 800
    select "Pasta",              from: "item[categories][]"
    attach_file "item[images][image]",
                "#{Rails.root}/app/assets/images/pizza_cat.jpg"
    fill_in "item[images][img_title]",       with: "Pizza Cat"
    fill_in "item[images][img_description]", with: "Pizza Cat Pic"
  end

  def fill_in_new_item_without_image
    fill_in "item[title]",       with: "Lasagna"
    fill_in "item[description]", with: "Steaming bowl of cheesy noodles."
    fill_in "item[unit_price]",  with: 800
    select "Pasta",              from: "item[categories][]"
    fill_in "item[images][img_title]",       with: "Pizza Cat"
  end

  def create_item
    image = create(:image)
    item = create(:item, title:       "milk",
                         description: "some cheese stuff",
                         image_id:    image.id)
    category = create(:category)
    item.categories << category
  end
end
