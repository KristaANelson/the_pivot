require "rails_helper"

describe "item creation" do
  include Capybara::DSL

  it "can create an item" do
    user = create(:user)
    event = create(:event)
    event.items << create(:item)
    visit root_path

    click_link("List a Ticket")
    expect(current_path).to eq(login_path)
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button("Log in")
    expect(current_path).to eq(new_ticket_path)
    select event.title, from: "item[event_id]"
    fill_in "item[section]", with: "RR"
    fill_in "item[row]", with: "55"
    fill_in "item[seat]", with: "55"
    fill_in "item[unit_price]", with: "55555"
    select "Physical", from: "item[delivery_method]"
    click_button("List Ticket")
    expect(current_path).to eq(user_store_path(user.slug))
    expect(page).to have_content(event.title)
    item = Item.last
    expect(page).to have_content(item.section)
  end
end
