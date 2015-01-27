require "spec_helper"

describe "the order view" do
  include Capybara::DSL
  attr_reader :item, :user


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

  it "shows the customer's full name and email" do
    mock_user
    create_one_item_with_one_category
    add_item_five_times_to_cart

    visit cart_path
    click_link_or_button("Checkout")

    expect(page).
    to have_content("Placed by: #{@user.full_name}, #{@user.email}")
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

  it "shows the each line item's quantity and subtotal" do
    mock_user
    create_one_item_with_one_category
    add_item_five_times_to_cart
    visit cart_path
    click_link_or_button("Checkout")
    order = user.orders.all.first

    visit order_path(order.id)

    within("tr##{@item.id}") do
      expect(page).to have_content("5")
      expect(page).to have_content(5 * @item.unit_price/100)
    end
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
