require "spec_helper"

describe "the order view" do
  include Capybara::DSL
  attr_reader :item, :user

  it "shows the order total" do
    mock_user
    item = create(:item)
    visit event_path(item.event_id)
    click_link_or_button("Add to cart")

    visit cart_path
    click_link_or_button("Checkout")

    expect(page).to have_content("Review Your Order!")
    expect(page).to have_content("Total: #{item.dollar_amount}")
  end

  it "shows the order time and status" do
    mock_user
    item = create(:item)
    visit event_path(item.event)
    click_link_or_button("Add to cart")

    visit cart_path
    click_link_or_button("Checkout")
    click_link_or_button("Submit Order")

    expect(page).to have_content("Order Details ")
    expect(page).to have_content(item.event.title)
  end

  it "shows links for each order item" do
    mock_user
    item = create(:item)
    visit event_path(item.event)
    click_link_or_button("Add to cart")

    visit cart_path
    click_link_or_button("Checkout")
    click_link_or_button("Submit Order")

    click_link("#{item.event.title}")

    expect(current_path).to eq(event_path(item.event))
  end

  it "shows the each line item's subtotal" do
    mock_user
    item = create(:item)
    visit event_path(item.event)
    click_link_or_button("Add to cart")

    visit cart_path
    click_link_or_button("Checkout")
    click_link_or_button("Submit Order")

    expect(page).to have_content(item.dollar_amount)
  end

  def mock_user
    @user = create(:user)
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(user)
  end
end
