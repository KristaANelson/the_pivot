require "spec_helper"

describe "admin venues", type: :feature do

  describe "the venue list page" do

    it "has a venue in there" do
      user = create(:admin)
      create(:venue)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
                                                  and_return(user)

      visit admin_venues_path

      expect(page).to have_link("Create Venue")
    end
  end

  describe "the venue add page" do

    it "has a venue add page" do
      user = create(:admin)
      allow_any_instance_of(ApplicationController). to receive(:current_user).
        and_return(user)

      visit new_admin_venue_path

      expect(page).to have_content("Create New Venue")
    end

    it "can add a venue" do
      user = create(:admin)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit new_admin_venue_path
      fill_in "venue[name]", with: "Wild Life"
      fill_in "venue[location]", with: "Denver, CO"
      click_link_or_button ("Submit")

      expect(page).to have_content("Wild Life")
    end

    it "redirects to venues page when done" do
      user = create(:admin)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

        visit new_admin_venue_path
        fill_in "venue[name]", with: "Wild Life"
        fill_in "venue[location]", with: "Denver, CO"
        click_link_or_button ("Submit")

      expect(current_path).to eq(admin_venues_path)
    end

    it "can edit a category" do
      user = create(:admin)
      venue = create(:venue)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit admin_venues_path
      expect(page).to have_content("Venues")
      visit edit_admin_venue_path(venue.id)
      expect(page).to have_button("Submit")
      fill_in "venue[name]", with: "Wild Life"
      click_link_or_button ("Submit")
      expect(page).to have_content("Wild Life")
    end

    it "cannot delete a venue with valid tickets" do
      user = create(:admin)
      event = create(:event)
      item = create(:item, user_id: user.id, event_id: event.id)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit admin_venues_path
      expect(page).to have_content("Venues")
      expect(page).to have_content("Delete")
      click_link_or_button ("Delete")
      expect(current_path).to eq(admin_venues_path)
      expect(page).to have_content(event.venue.name)
      expect(page).to have_content("Cannot delete")
    end

    it "can delete a venue with no valid tickets" do
      user = create(:admin)
      venue = create(:venue)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit admin_venues_path
      expect(page).to have_content("Venues")
      expect(page).to have_content("Delete")
      click_link_or_button ("Delete")
      expect(current_path).to eq(admin_venues_path)
      expect(page).to_not have_content(venue.name)
    end
  end
end
