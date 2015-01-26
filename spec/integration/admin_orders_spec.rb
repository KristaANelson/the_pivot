require "spec_helper"

describe "the order dashboard", type: :feature do
  it "shows all the orders" do
    mock_admin
    mock_order

    visit admin_path

    expect(page).to have_content("Recent Orders")
    save_and_open_page
  end

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(admin)
  end

  def mock_order
    user = create(:user)
    order = Order.create(user_id: user.id,
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
