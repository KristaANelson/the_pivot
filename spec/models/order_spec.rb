require "rails_helper"

describe Order, type: "model" do

  it "is valid when it has a user" do
    order = Order.new(user_id: 1)
    expect(order).to be_valid
  end

  it "is invalid when it does not have a user" do
    order = Order.new(user_id: nil)
    expect(order).not_to be_valid
  end

  it "has a relationship to user that works" do
    user = User.all.first
    order = Order.create(user_id: user.id)
    expect(order.user).to be_truthy
  end

  xit "has a relationship to an item" do
    user = User.all.first
    item = Item.new(title:        "title",
                    description:  "something",
                    unit_price:   1)
    order = Order.create(user_id: user.id, item_id: item.id)
    expect(order.item).to be_truthy
  end
end
