require "spec_helper"

describe "the cart view", type: :feature do
  include Capybara::DSL

  before(:each) do
    visit cart_path
    user = FactoryGirl.build(:user)
    require 'pry'; binding.pry
    puts user.pretty_print_inspect
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
    expect(page).to have_content(Item.find(5000).description)
    expect(page).to have_content(Item.find(5000).title)
  end

  it "has a link to remove each line item" do
    visit menu_path
    5.times do
      first(:button, "Add to cart").click
      page.all(:button, "Add to cart")[37].click
    end
    visit cart_path
    expect(page).to have_content(Item.find(5000).description)
    expect(page).to have_content("Quantity: 5")
    first(:button, "X").click
    expect(page).not_to have_content(Item.find(5000).description)
  end

  it "has a link to add one to each line item" do
    visit menu_path
    5.times do
      first(:button, "Add to cart").click
    end
    8.times do
      page.all(:button, "Add to cart")[37].click
    end
    visit cart_path
    first(:button, "+").click
    expect(page).to have_content("Quantity: 6")
    page.all(:button, "+")[1].click
    expect(page).to have_content("Quantity: 9")
  end
end
