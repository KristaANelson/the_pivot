require "spec_helper"

describe "the order dashboard", type: :feature do
  it "shows all the orders" do
    mock_admin

    visit admin_path

    expect(page).to have_content("Recent Orders")
  end

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(admin)
  end
end
