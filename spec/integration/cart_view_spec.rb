require "spec_helper"

describe "the cart view", type: :feature do
  include Capybara::DSL
  attr_reader :item

  it "has no items by default" do
    visit cart_path

    expect(page).to have_content("Your cart is empty!")
    expect(page).to_not have_button("Checkout")
  end

  it "displays cart items" do
    item = create(:item)

    visit event_path(item.event)
    first(:button, "Add to cart").click
    visit cart_path

    expect(page).to have_content(item.event.description)
    expect(page).to have_content(item.event.title)
  end

  it "has a link to remove each line item" do
    item = create(:item)

    visit event_path(item.event)
    first(:button, "Add to cart").click
    visit cart_path
    first(:button, "Remove").click

    expect(page).not_to have_content(item.event.title)
  end

  it "has a checkout link and prompts login" do
    item = create(:item)

    visit event_path(item.event)
    first(:button, "Add to cart").click
    visit cart_path
    click_link("Checkout")

    expect(page).to have_content("Sign into your account")
  end
end
