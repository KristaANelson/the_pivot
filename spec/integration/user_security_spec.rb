require "spec_helper"

describe "users cannot access any admin things", type: :feature do

  describe "admin dashboard" do

    it "cannot access the admin dashboard" do
      mock_user

      visit admin_path

      expect(current_path).to eq(root_path)
    end
  end

  describe "items listing" do

    it "cannot access items index as a user" do
      mock_user

      visit items_path

      expect(current_path).to eq(root_path)
    end

    it "cannot create a new item" do
      mock_user

      visit new_item_path

      expect(current_path).to eq(root_path)
    end
  end

  describe "categories listing" do

    it "cannot access categories index as a user" do
      mock_user

      visit categories_path

      expect(current_path).to eq(root_path)
    end

    it "cannot create a new category" do
      mock_user

      visit new_category_path

      expect(current_path).to eq(root_path)
    end

    it "cannot edit a category" do
      mock_user
      cat = create(:category)

      visit edit_category_path(cat.id)

      expect(current_path).to eq(root_path)
    end

  end

  def mock_user
    user = create(:user)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)
  end

end
