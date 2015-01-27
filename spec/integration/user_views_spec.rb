require "rails_helper"

describe "the user" do
  include Capybara::DSL
  attr_reader :item, :user

  it "sees a Login button on homepage" do
    visit root_path

    expect(page).to have_link("Login")
    expect(page).to_not have_link("Logout")
  end

  it "a user going to a non defined route gets redirected to the home page" do
    visit "/something"

    expect(current_path).to eq(root_path)
  end

  it "redirects a user to the home page if trying to access admin dash" do
    visit "/admin"

    expect(current_path).to eq(root_path)
  end

  it "cannot log in with invalid credentials" do
    visit root_path
    click_link("Login")
    fill_in "session[email]", with: ""
    fill_in "session[password]", with: ""
    click_link_or_button("Log in")

    expect(page).to have_content("Invalid Login")
  end

  it "can see a signup button" do
    visit root_path
    click_link("Login")

    expect(page).to have_link("Create account")
  end

  it "can create an account" do
    user = build(:user)

    visit root_path
    click_link("Login")
    click_link("Create account")
    fill_in "user[full_name]", with: user.full_name
    fill_in "user[display_name]", with: user.display_name
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password
    click_button("Create my account!")

    expect(page).to have_content("Account successfully created. ")
  end

  it "cannot create an account with invalid credentials" do
    user = create(:user)

    visit root_path
    click_link("Login")
    click_link("Create account")
    fill_in "user[full_name]", with: "123"
    fill_in "user[display_name]", with: "a"
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "pass"
    fill_in "user[password_confirmation]", with: "word"
    click_button("Create my account!")

    expect(page).to have_content("password_confirmation: doesn't match")
    expect(page).to have_content("full_name: Incorrect name format")
    expect(page).to have_content("email: has already been taken")
    expect(page).to have_content("display_name: is too short")
  end

  it "can login" do
    user = create(:user)

    visit root_path
    click_link_or_button("Login")
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button("Log in")

    expect(page).to have_content("Successfully logged in")
  end

  it "is redirected back to the page it came from" do
    user = build(:user)

    visit menu_path
    click_link("Login")
    click_link("Create account")
    fill_in "user[full_name]", with: user.full_name
    fill_in "user[display_name]", with: user.display_name
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password
    click_button("Create my account!")

    expect(current_path).to eq menu_path
  end

  it "sees a Logout button instead of Login " do
    mock_user

    visit root_path

    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end

  it "cannot see another users information" do
    exisiting_user = create(:user, full_name: "Sue Sue", email: "sue@sue.com")
    mock_user
    Order.create(user_id: exisiting_user.id, status:  "ordered")

    visit root_path
    click_link_or_button("Past Orders")

    expect(page).to_not have_link("1")
  end

  it "can log out" do
    mock_user

    visit root_path
    click_link("Logout")

    expect(page).to have_content("Successfully logged out")
  end

  it "shows a past orders link in the right nav bar" do
    mock_user

    visit root_path

    within(".menu_right") do
      expect(page).to have_link("Past Orders")
    end
  end

  it "sees a page called order summary after clicking checkout" do
    mock_user
    create_one_item_with_one_category
    add_item_five_times_to_cart

    visit cart_path
    click_link_or_button("Checkout")

    expect(page).to have_content("Order Summary")
  end

  it "gets redirected to home page if user tries to access admin page" do
    mock_user

    visit admin_path

    expect(current_path).to eq(root_path)
  end

  describe "the order view" do

    it "shows the order total" do
      mock_user
      create_one_item_with_one_category
      add_item_five_times_to_cart

      visit cart_path
      click_link_or_button("Checkout")

      expect(page).to have_content("Order Summary")
      expect(page).to have_content("Order Total: $#{5 * @item.unit_price / 100}")
    end

    it "shows the order time and status" do
      mock_user
      create_one_item_with_one_category
      add_item_five_times_to_cart

      visit cart_path
      click_link_or_button("Checkout")

      expect(page).to have_content("Order placed at: ")
      expect(page).to_not have_content("Order cancelled at: ")
      expect(page).to_not have_content("Order completed at: ")
      expect(page).to have_content("Current status: ordered")
    end

    it "shows links for each order item" do
      mock_user
      create_one_item_with_one_category
      add_item_five_times_to_cart

      visit cart_path
      click_link_or_button("Checkout")

      within("table") do
        click_link("#{@item.title}")
      end

      expect(current_path).to eq(item_path(@item.id))
      expect(page).to have_link("#{@item.title}")
    end

    it "shows the order completed time if order completed" do
      mock_user
      create_one_item_with_one_category
      add_item_five_times_to_cart

      visit cart_path
      click_link_or_button("Checkout")
      order = user.orders.all.first
      order.update_attributes(status: "completed")
      visit order_path(order.id)

      expect(page).to have_content("Order completed at: ")
      expect(page).to have_content("Current status: completed")
    end

    it "shows the order cancelled time if order cancelled" do
      mock_user
      create_one_item_with_one_category
      add_item_five_times_to_cart

      visit cart_path
      click_link_or_button("Checkout")
      order = user.orders.all.first
      order.update_attributes(status: "cancelled")
      visit order_path(order.id)

      expect(page).to have_content("Order cancelled at: ")
      expect(page).to have_content("Current status: cancelled")
    end
  end

  describe "the past orders view" do
    it "shows the past orders for a user" do
      mock_user
      visit root_path

      click_link("Past Orders")

      expect(current_path).to eq(orders_path)
      expect(page).to have_content("Your Past Orders")
    end

    it "shows the details for a past order" do
      mock_user
      order = Order.create(user_id: user.id,
                           status:  "ordered",
                           total_price: 14678)
      item = create(:item)
      order_item = OrderItem.create(order_id: order.id,
                                    item_id: item.id,
                                    quantity: 5,
                                    line_item_price: 5 * item.unit_price)
      order.order_items << order_item

      visit root_path
      click_link("Past Orders")

      within("tbody") do
        expect(page).to have_content("#{order.total_dollar_amount}")
        expect(page).
        to have_content("#{order.formatted_time(order.created_at)}")
      end
    end
  end

  def mock_user
    @user = create(:user)
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(user)
  end

  def create_one_item_with_one_category
    image = create(:image)
    @item = create(:item, image_id: image.id)
    category = create(:category)
    item.categories << category
  end

  def add_item_five_times_to_cart
    visit menu_path
    5.times do
      first(:button, "Add to cart").click
    end
  end
end
