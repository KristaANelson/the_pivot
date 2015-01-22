require "spec_helper"

describe "the cart view", type: :feature do
  include Capybara::DSL

  before(:each) do
    visit cart_path
    @cart = Cart.new
  end

  it "exists" do
    expect(current_path).to eq(cart_path)
  end

  it "has no items by default" do
    expect(page).to have_content("Your cart is empty!")
  end

  it "displays cart items" do
    visit menu_path
    first(:button, "Add to cart").click
    visit cart_path
    save_and_open_page
    expect(page).to have_content(Item.find(5000).description)
    expect(page).to have_content(Item.find(5000).title)
  end
end
