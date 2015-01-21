rnequire 'rails_helper'

describe 'the user' do
  include Capybara::DSL
  attr_reader :user

  before(:each) do
    @user = User.find_by(display_name: 'david')
    @item = Item.find_all_by(active?: false).first
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit root_url
  end


  it 'sees a Logout button instead of Login ' do
    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end

  xit 'can log out' do
    click_link_or_button("Logout")
    execpt(page).to have_content("Successfully logged out")
    visit user_path(user)
    expect(page).to have_content("Not authorized for this page")
  end

  xit 'sees list of past orders' do
    click_link_or_button("Profile")
    expect(page).to have_content("Past Orders")
    expect(page).to have_link("Order 2")
    expect(page).to_not have_link("Order 3")
  end

  xit 'views items from order' do
    visit order_path
    within("#Item_1") do
      expect(page).to have_link("Garden Salad")
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Line Item Subtotal: $6.00")
    end
  end

  xit 'views order details' do
    visit order_path
    within("#order_details") do
      expect(page).to have_content("Order Submitted: 1/20/2015 10:30pm")
      expect(page).to have_content("Order total: $21.00")
      expect(page).to have_content("Order Status: completed on 1/20/2015 11:03pm")
    end
  end

  xit 'can see retired items' do
    visit item_path(item)
    expect(page).to have_content("Item details")
  end

  xit 'cannot add retuired item to cart' do
    visit item_path(item)
    expect(page).to_not have_link("Add to cart")
  end
end
