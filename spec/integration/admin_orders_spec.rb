require "spec_helper"

describe "the order dashboard", type: :feature do
  attr_reader :order, :completed_order, :user

  it "shows all the orders" do
    mock_admin
    mock_order

    visit admin_path

    expect(page).to have_content("Recent Orders")
    within("table.table.table-striped.orders-table") do
      expect(page).to have_link("#{order.id}")
    end
  end

  it "links to each order detail page" do
    mock_admin
    mock_order

    visit admin_path
    within("table.table.table-striped.orders-table") do
      click_link("#{order.id}")
    end

    expect(current_path).to eq(order_path(order.id))
  end

  it "can filter by status" do
    mock_admin
    mock_order
    mock_completed_order

    visit admin_path
    click_button("Ordered")

    expect(page).to have_link("#{order.id}")
    expect(page).to_not have_link("#{completed_order.id}")
  end

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(admin)
  end

  def mock_order
    @user = create(:user)
    @order = Order.create(user_id: user.id,
                          status:  "ordered",
                          total_price: 14678)
    item = create(:item)
    order_item = OrderItem.create(order_id:        order.id,
                                  item_id:         item.id,
                                  quantity:        5,
                                  line_item_price: 5 * item.unit_price)
    order.order_items << order_item
  end

  def mock_completed_order
    @completed_order = Order.create(user_id: user.id,
                                    status:  "completed",
                                    total_price: 146789)
  end
end
