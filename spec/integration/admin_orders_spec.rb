require "spec_helper"

describe "the order dashboard", type: :feature do
  attr_reader :order, :completed_order, :user, :paid_order

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

    within("table.table.table-striped.orders-table") do
      expect(page).to have_link("#{order.id}")
      expect(page).to_not have_link("#{completed_order.id}")
    end
  end

  it "shows total count by status" do
    mock_admin
    mock_order
    mock_completed_order
    mock_seven_paid_orders

    visit admin_path
    click_button("Ordered")

    within("div.dash-section.clearfix.summary") do
      expect(page).to have_content("1")
      expect(page).to have_content("7")
      expect(page).to have_content("9")
    end
  end

  it "allows admin to change order's status from ordered to paid" do
    mock_admin
    mock_order

    visit admin_path
    within("tr##{@order.id}") do
      click_link("Mark Paid")
    end

    within("tr##{@order.id}") do
      expect(page).to have_content("paid")
      expect(page).to_not have_content("ordered")
    end
  end

  it "allows admin to change order's status from paid to completed" do
    mock_admin
    mock_order
    visit admin_path
    within("tr##{@order.id}") do
      click_link("Mark Paid")
    end

    visit admin_path
    within("tr##{@order.id}") do
      click_link("Mark Complete")
    end

    within("tr##{@order.id}") do
      expect(page).to have_content("completed")
      expect(page).to_not have_content("paid")
    end
  end

  it "allows admin to change ordered/paid order's status to cancelled" do
    mock_admin
    mock_order
    mock_paid_order

    visit admin_path
    within("tr##{@order.id}") do
      click_link("Cancel Order")
    end
    within("tr##{@paid_order.id}") do
      click_link("Cancel Order")
    end

    within("tr##{@order.id}") do
      expect(page).to_not have_link("Mark Paid")
      expect(page).to have_content("cancelled")
      expect(page).to_not have_content("ordered")
    end
    within("tr##{@paid_order.id}") do
      expect(page).to_not have_link("Mark Paid")
      expect(page).to have_content("cancelled")
      expect(page).to_not have_content("ordered")
    end
  end

  it "allows does not allow admin to change a completed order's status" do
    mock_admin
    mock_completed_order

    visit admin_path

    within("tr##{@completed_order.id}") do
      expect(page).to_not have_link("Mark Paid")
      expect(page).to_not have_link("Cancel Order")
      expect(page).to_not have_link("Mark Complete")
      expect(page).to have_content("completed")
    end
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
