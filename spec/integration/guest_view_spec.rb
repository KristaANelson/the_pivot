require "spec_helper"

describe "the guest view", type: :feature do
  describe "the home page" do

    it "has a navbar" do
      visit root_path

      expect(page).to have_link("Connect")
      expect(page).to have_link("Tickets")
      expect(page).to have_link("Sell")
      expect(page).to have_link("My Hubstub")
    end

    it "redirects a guest to the home page when going to a non existing url" do
      visit "/something"

      expect(current_path).to eq(root_path)
    end

    it "redirects a guest to home when going to admin dashboard" do
      visit "/something"

      expect(current_path).to eq(root_path)
    end

    it "has no link to admin login" do
      visit root_path

      expect(page).not_to have_link("Dashboard")
    end

    it "goes to the menu page" do
      visit root_path

      page.click_link("All Tickets")
      expect(current_path).to eq(tickets_path)
    end

    it "goes to the cart page" do
      visit root_path

      page.click_link("Cart")
      expect(current_path).to eq(cart_path)
    end
  end

  describe "the tickets view" do
    it "shows active events" do
      event = create(:event)
      event.category = create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit tickets_path

      expect(page).to have_content(event.title)
      expect(page).to have_content(event.venue.name)
      expect(page).to have_content("1 Ticket")
    end

    it "has a link to the respective event" do
      event = create(:event)
      event.category = create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit tickets_path

      page.click_link(event.title)
      expect(current_path).to eq(event_path(event))
    end

    it "filters events based on category" do
      event1 = create(:event)
      event2 = create(:event)
      user = create(:user)
      create(:item, user_id: user.id, event_id: event1.id)
      create(:item, user_id: user.id, event_id: event2.id)

      visit tickets_path(category: event1.category.name)

      expect(page).to have_content(event1.title)
      expect(page).to have_content(event1.venue.name)
      expect(page).to_not have_content(event2.title)
      expect(page).to_not have_content(event2.venue.name)
    end

    it "doesn't show past events" do
      event = create(:event, date: 2.days.ago)
      event.category = create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    it "doesn't show unapproved events" do
      event = create(:event, approved: false)
      event.category = create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    it "doesn't show events with no items" do
      event = create(:event)
      event.category = create(:category)
      user = create(:user)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    it "doesn't show events with only sold tickets" do
      event = create(:event)
      event.category = create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id, sold: true)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    it "doesn't show events with only pending tickets" do
      event = create(:event)
      event.category = create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id, sold: true)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    it "has a buy dropdown in navbar for categories" do
      visit root_path

      within(".navbar") do
        expect(page).to have_content("Buy")
      end
    end

    it "links to the correct categories" do
      item = create(:item)

      visit "/tickets?category=#{item.category.name}"
      expect(page).to have_content(item.category.name)
    end

    it "has add-to-cart links for each item" do
      event = create(:event)
      event.category = create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit event_path(item.event_id)
      expect(page).to have_button("Add to cart")
    end
  end

  describe "the event view" do
    it "shows the event details" do
      event = create(:event)
      event.category = create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit event_path(event)

      expect(page).to have_content(event.title)
      expect(page).to have_content(event.venue.name)
      expect(page).to have_link(event.items.first.user.display_name)
      expect(page).to have_content(event.items.first.section)
      expect(page).to have_content(event.items.first.row)
      expect(page).to have_content(event.items.first.seat)
      expect(page).to have_content(event.items.first.delivery_method.capitalize)
      expect(page).to have_button("Add to cart")
    end
  end

  describe "prohibited paths" do
    it "redirects the guest to the root when attempting to visit orders_path" do
      visit orders_path

      expect(current_path).to eq(root_path)
    end

    it "does not allow guest access to the admin page" do
      visit admin_path

      expect(current_path).to eq(root_path)
    end

    it "does not allow guest access to user pages" do
      user = create(:user)
      visit admin_user_path(user.id)

      expect(current_path).to eq(root_path)
    end
  end

  describe "an individual seller page" do
    it "routes to the seller path" do
      user = create(:user)
      visit seller_store_path(user.slug)

      expect(current_path).to eq(seller_store_path(user.slug))
    end


    it "can view an individual seller's page" do
      user = create(:user)
      ticket = create(:item)
      event = create(:event)
      ticket.event_id = event.id
      user.items << ticket

      visit seller_store_path(user.slug)

      expect(page).to have_content("$5.00")
      expect(page).to have_content("John Bob Smith")
    end

    it "doesn't show past events" do
      event = create(:event, date: 2.days.ago)
      event.category = create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit seller_store_path(user.slug)

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end
  end

  def create_item
    image = create(:image)
    create(:item,
           title: "milk",
           description: "some cheese stuff",
           image_id: image.id)
  end

end
