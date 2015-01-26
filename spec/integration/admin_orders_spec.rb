require "spec_helper"

describe "the order dashboard", type: :feature do
  attr_reader :order

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

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(admin)
  end

  def mock_order
    user = create(:user)
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
end
