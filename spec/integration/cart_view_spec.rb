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
    create_one_item_with_one_category

    visit menu_path
    first(:button, "Add to cart").click
    visit cart_path

    expect(page).to have_content(item.description)
    expect(page).to have_content(item.title)
    expect(page).to have_content("Quantity: 1")

  end

  it "has a link to remove each line item" do
    create_one_item_with_one_category
    add_item_five_times_to_cart

    visit cart_path
    first(:button, "X").click

    expect(page).not_to have_content(item.description)
  end

  it "has a link to add one to each line item" do
    create_one_item_with_one_category
    add_item_five_times_to_cart

    visit cart_path
    first(:button, "+").click

    expect(page).to have_content("Quantity: 6")
  end

  it "has a checkout link and prompts login" do
    create_one_item_with_one_category
    add_item_five_times_to_cart

    visit cart_path
    click_link("Checkout")

    expect(page).to have_content("Sign into your account")
  end


  def create_one_item_with_one_category
    @item = FactoryGirl.create(:item)
    category = FactoryGirl.create(:category)
    item.categories << category
  end

  def add_item_five_times_to_cart
    visit menu_path
    5.times do
      first(:button, "Add to cart").click
    end
  end
end
