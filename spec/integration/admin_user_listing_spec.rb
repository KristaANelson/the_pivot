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
      visit admin_user_path(user)
      expect(page).to have_content(item.unit_price)
    end
  end

  describe "freeze and unfreeze a user account" do

    it "an admin can freeze a user accout" do
      mock_admin
      user = create(:user)
      event = create(:event)
      item = create(:item, unit_price: 59, user_id: user.id, event_id: event.id)
      visit admin_users_path
      expect(page).to have_content("Users")
      expect(page).to have_content(user.full_name)
      expect(page).to have_content("Freeze")
      click_link_or_button("Freeze")
      expect(page).to have_content("Unfreeze")
      click_link_or_button("Listings")
    end

    it "an admin can unfreeze a user accout" do
      mock_admin
      user = create(:user)
      event = create(:event)
      item = create(:item, unit_price: 59, user_id: user.id, event_id: event.id)
      visit admin_users_path
      expect(page).to have_content("Users")
      expect(page).to have_content(user.full_name)
      expect(page).to have_content("Freeze")
      click_link_or_button("Freeze")
      expect(page).to have_content("Unfreeze")
      click_link_or_button("Unfreeze")
      expect(page).to have_content("Freeze")
      click_link_or_button("Listings")
      expect(page).to have_content(item.unit_price)
    end

    xit "an admin can see void a listing" do
      mock_admin
      user = create(:user)
      event = create(:event)
      item = create(:item, unit_price: 59, user_id: user.id, event_id: event.id)
      visit admin_users_path
      expect(page).to have_content("Users")
      expect(page).to have_content(user.full_name)
      expect(page).to have_content("Listings")
      visit admin_user_path(user)
      expect(page).to have_content(item.unit_price)
      click_link_or_button("Void Listing")
      visit admin_void_item_path(item)
      expect(item.pending).to eq(true)
      expect(page).to have_button("Unvoid")
    end
  end

  private

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(admin)
  end
end
