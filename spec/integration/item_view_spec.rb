require "rails_helper"

describe "the user item view" do
  include Capybara::DSL
  attr_reader :image

  before(:each) do
    user = create(:user)
    allow_any_instance_of(ApplicationController). to receive(:current_user).
    and_return(user)
    @image = create(:image)
  end

  xit "shows an add to cart button for active items" do
    item = create(:item, image_id: @image.id)

    visit item_path(item.id)

    expect(page).to have_button("Add to cart")
  end

  xit "does not show an add to cart button for retired items" do
    item = create(:item, active: false, image_id: @image.id)

    visit item_path(item.id)

    expect(page).to_not have_button("Add to cart")
  end
end
