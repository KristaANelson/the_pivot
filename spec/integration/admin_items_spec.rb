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

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(admin)
  end
end
