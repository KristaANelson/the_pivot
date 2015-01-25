require "spec_helper"

describe "admin items control", type: :feature do

  describe "viewing the item listing" do

    it "an admin can see an item listing page" do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)
      visit items_path
      expect(page).to have_content("Items")
    end
  end
end
