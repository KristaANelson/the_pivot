require "rails_helper"

describe "the user" do
  include Capybara::DSL

  it "sees a Login button on homepage" do
    visit root_path
    expect(page).to have_link("Login")
    expect(page).to_not have_link("Logout")
  end

  it "cannot log in with invalid credentials" do
    visit root_path
    click_link("Login")
    save_and_open_page
    fill_in "session[email]", with: ""
    fill_in "session[password]", with: ""
    click_link_or_button("Log in")
  end

  it "can see a signup button" do
    visit root_path
    click_link("Login")
    expect(page).to have_link("Create account")
  end

  it "can create an account" do
    visit login_path
    click_link("Create account")
    save_and_open_page
    fill_in "user[full_name]", with: "First Last"
    fill_in "user[display_name]", with: "example_user"
    fill_in "user[email]", with: "example_user@email.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button("Create my account!")
    expect(page).to have_contenet("User successfully created")
  end

  xit "can login" do
    click_link_or_button("Login")
    fill_in "users[display_name]", with: "example_user"
    fill_in "users[password]", with: "password"
    click_link_or_button("Login")
    expect(page).to have_contenet("Successfully loged in")
    exect(page).to_not have_link_or_button("Login")
    exect(page).to have_link_or_button("Logout")
  end

  xit "sees a Logout button instead of Login " do
    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end

  xit "can log out" do
    click_link_or_button("Logout")
    execpt(page).to have_content("Successfully logged out")
    visit user_path(user)
    expect(page).to have_content("Not authorized for this page")
  end

  xit "sees list of past orders" do
    click_link_or_button("Profile")
    expect(page).to have_content("Past Orders")
    expect(page).to have_link("Order 2")
    expect(page).to_not have_link("Order 3")
  end

  xit "views items from order" do
    visit order_path
    within("#Item_1") do
      expect(page).to have_link("Garden Salad")
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Line Item Subtotal: $6.00")
    end
  end

  xit "views order details" do
    visit order_path
    within("#order_details") do
      expect(page).to have_content("Order Submitted: 1/20/2015 10:30pm")
      expect(page).to have_content("Order total: $21.00")
      expect(page).to have_content("Order Status: completed on 1/20/2015 11:03pm")
    end
  end

  xit "can see retired items" do
    visit item_path(item)
    expect(page).to have_content("Item details")
  end

  xit "cannot add retuired item to cart" do
    visit item_path(item)
    expect(page).to_not have_link("Add to cart")
  end
end
