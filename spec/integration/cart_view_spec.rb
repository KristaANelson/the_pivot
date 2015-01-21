require "spec_helper"

describe "the cart view", type: :feature do
  include Capybara::DSL

  xit "exists" do
    visit cart_path
    expect(current_path).to eq(cart_path)
  end
end
