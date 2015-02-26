require "spec_helper"

describe "the order dashboard", type: :feature do
  attr_reader :order, :completed_order, :user, :paid_order

  it "shows all the orders" do
    mock_admin
    mock_order

    visit admin_path

    expect(page).to have_content("Recent Orders")
    expect(page).to have_link("#{order.id}")
  end

  it "links to each order detail page" do
    mock_admin
    mock_order

    visit admin_path
    click_link("#{order.id}")

    expect(current_path).to eq(seller_order_path(@user.slug, order.id))
  end

  it "allows does not allow admin to change a completed order's status" do
    mock_admin
    mock_completed_order

    visit admin_path

    expect(page).to_not have_link("Mark Paid")
    expect(page).to_not have_link("Cancel Order")
    expect(page).to_not have_link("Mark Complete")
    expect(page).to have_content("completed")
  end

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).and_return(admin)
  end

  def mock_order
    mock_user
    item = create(:item)
    @order = Order.create(user_id: user.id,
                          status:  "ordered")
    @order.create_order_items(Cart.new([item.id]))
  end

  def mock_paid_order
    mock_user
    @paid_order = Order.create(user_id: user.id,
                               status:  "paid",
                               total_price: 1428)
  end

  def mock_user
    @user ||= create(:user)
  end

  def mock_completed_order
    mock_user
    @completed_order = Order.create(user_id: user.id,
                                    status:  "completed",
                                    total_price: 146789)
  end

  def mock_seven_paid_orders
    7.times do
      Order.create(user_id: user.id,
                   status:  "paid",
                   total_price: 1469)
    end
  end
end
