require "rails_helper"

describe "the user" do
  include Capybara::DSL
  attr_reader :item

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

  xit "cannot create an account without a valid email" do
    user = build(:user)
    visit root_path
    click_link("Login")
    click_link("Create account")
    fill_in "user[full_name]", with: ""
    fill_in "user[display_name]", with: user.display_name
    fill_in "user[email]", with: "email"
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password
    click_button("Create my account!")

    save_and_open_page

  end


  it "can login" do
    user = create(:user)

    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button("Log in")

    expect(page).to have_content("Successfully logged in")
  end

  it "sees a Logout button instead of Login " do
    user = create(:user)
    allow_any_instance_of(ApplicationController). to receive(:current_user).
                                                  and_return(user)

    visit root_path

    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end

  it "can log out" do
    user = create(:user)
    allow_any_instance_of(ApplicationController). to receive(:current_user).
                                                  and_return(user)

    visit root_path
    click_link("Logout")

    expect(page).to have_content("Successfully logged out")
  end

  it "shows a past orders link in the right nav bar" do
    user = create(:user)
    allow_any_instance_of(ApplicationController). to receive(:current_user).
    and_return(user)

    visit root_path

    within(".menu_right") do
      expect(page).to have_link("Past Orders")
    end
  end

  it "sees a page called order summary after clicking checkout" do
    user = create(:user)
    allow_any_instance_of(ApplicationController). to receive(:current_user).
                                                  and_return(user)
    create_one_item_with_one_category
    add_item_five_times_to_cart
    visit cart_path

    click_link_or_button("Checkout")

    expect(page).to have_content("Order Summary")
  end

  it "gets redirected to home page if user tries to access admin page" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user)

    visit admin_path

    expect(current_path).to eq(root_path)
  end

  describe "the order view" do

    it "shows the order total" do
      user = create(:user)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
      and_return(user)
      create_one_item_with_one_category
      add_item_five_times_to_cart

      visit cart_path
      click_link_or_button("Checkout")

      expect(page).to have_content("Order Summary")
      expect(page).to have_content("Order Total: $#{5 * @item.unit_price / 100}")
    end

    it "shows the order time and status " do
      user = create(:user)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
      and_return(user)
      create_one_item_with_one_category
      add_item_five_times_to_cart

      visit cart_path
      click_link_or_button("Checkout")

      expect(page).to have_content("Order placed at: ")
      expect(page).to have_content("Current status: ordered")
    end

    it "shows the order time and status" do
      user = create(:user)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
      and_return(user)
      create_one_item_with_one_category
      add_item_five_times_to_cart

      visit cart_path
      click_link_or_button("Checkout")

      expect(page).to have_content("Order placed at: ")
      expect(page).to have_content("Current status: ordered")
    end

    it "shows links for each order item" do
      user = create(:user)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
      and_return(user)
      create_one_item_with_one_category
      add_item_five_times_to_cart

      visit cart_path
      click_link_or_button("Checkout")

      within("table") do
        click_link("#{@item.title}")
      end

      expect(current_path).to eq(item_path(@item.id))
    end
  end

  describe "the past orders view" do
    it "shows the past orders for a user" do
      user = create(:user)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
      and_return(user)
      visit root_path

      click_link("Past Orders")

      expect(current_path).to eq(orders_path)
      expect(page).to have_content("Your Past Orders")
    end
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
