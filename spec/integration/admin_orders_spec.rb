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

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).and_return(admin)
  end

  def mock_order
    @user = create(:user)
    @order = Order.create(user_id: user.id,
                          status:  "ordered",
                          total_price: 14678)
  end

  def mock_completed_order
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
