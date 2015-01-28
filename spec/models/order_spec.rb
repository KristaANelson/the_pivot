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
    user = FactoryGirl.create(:user, email: "stuff@stuff.com")
    order = Order.create(user_id: user.id)

    expect(order.user).to be_truthy
  end

  it "has order items" do
    user2 = create(:user, full_name: "bob bob", email: "bob@gmail.com")
    item = create(:item)
    order = Order.create(user_id: user2.id, status: "paid", total_price: 500)
    OrderItem.create(order_id: order.id, item_id: item.id, quantity: 5)
    expect(order.order_items.count).to eq(1)
  end

  it "has a sorted method" do
    user2 = create(:user, full_name: "bob bob", email: "bob@gmail.com")
    order = Order.create(user_id: user2.id, status: "paid", total_price: 500)
    order2 = Order.create(user_id: user2.id, status: "paid", total_price: 540)
    expect(Order.sorted).to eq([order2, order])
  end
end
