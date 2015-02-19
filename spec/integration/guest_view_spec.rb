require "spec_helper"

describe "the guest view", type: :feature do
  describe "the home page" do

    it "has a navbar" do
      visit root_path

      expect(page).to have_link("Connect")
      expect(page).to have_link("Buy")
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
      expect(current_path).to eq(root_path)
    end
  end

  describe "the tickets view" do
    it "shows active events" do
      event = create(:event)
      event.categories << create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit tickets_path

      expect(page).to have_content(event.title)
      expect(page).to have_content(event.venue.name)
      expect(page).to have_content("1 Ticket")
    end

    it "has a link to the respective event" do
      event = create(:event)
      event.categories << create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit tickets_path

      page.click_link(event.title)
      expect(current_path).to eq(event_path(event))
    end

    it "doesn't show past events" do
      event = create(:event, date: 2.days.ago)
      event.categories << create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    it "doesn't show unapproved events" do
      event = create(:event, approved: false)
      event.categories << create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    it "doesn't show events with no items" do
      event = create(:event)
      event.categories << create(:category)
      user = create(:user)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    it "doesn't show events with only sold tickets" do
      event = create(:event)
      event.categories << create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id, sold: true)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    it "doesn't show events with only pending tickets" do
      event = create(:event)
      event.categories << create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id, sold: true)

      visit tickets_path

      expect(page).to_not have_content(event.title)
      expect(page).to_not have_content(event.venue.name)
      expect(page).to_not have_content("1 Ticket")
    end

    xit "has a side navbar for menu categories" do
      visit menu_path

      within(".sidebar-nav") do
        Category.all.each do |category|
          expect(page).to have_link(category.name)
        end
      end
    end

    xit "links to the correct menu categories" do
      create(:category, name: "Salads")

      visit menu_path
      page.click_link("Salads")

      expect(current_path).to eq(menu_path)
    end

    xit "has add-to-cart links for each item" do
      create_item

      visit menu_path

      within first(".item-box") do
        expect(page).to have_button("Add to cart")
      end
    end
  end

  describe "the event view" do
    it "shows the event details" do
      event = create(:event)
      event.categories << create(:category)
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
      visit admin_show_user_path(user.id)

      expect(current_path).to eq(root_path)
    end
  end

  describe "an individual seller page" do
    it "can view an individual seller's page" do
      user = create(:user)
      ticket = create(:item)
      event = create(:event)
      ticket.event_id = event.id
      user.items << ticket

      visit user_store_path(user.slug)
      expect(page).to have_content("$5.00")
      expect(page).to have_content("John Bob Smith")
    end

    it "doesn't show past events" do
      event = create(:event, date: 2.days.ago)
      event.categories << create(:category)
      user = create(:user)
      item = create(:item, user_id: user.id, event_id: event.id)

      visit user_store_path(user.slug)

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
