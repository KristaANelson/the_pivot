require "spec_helper"

describe "admin items view", type: :feature do

  describe "viewing user listing" do

    it "can see users in index" do
      mock_admin
      user = create(:user)

      visit admin_path
      click_link "Manage Users"
      expect(page).to have_content(user.full_name)
    end
  end

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(admin)
  end
end
