require "spec_helper"

describe "admin can manage events", type: :feature do

  it "can see all events" do
    mock_admin
    event = create(:event)
    visit admin_events_path
    expect(page).to have_content("Events")
    expect(page).to have_content(event.title)
  end

  it "can see create an event " do
    mock_admin
    event = create(:event)
    visit admin_events_path
    expect(page).to have_content("Events")
    expect(page).to have_content(event.title)
    expect(page).to have_content("Create Event")
    click_link_or_button("Create Event")
    expect(page).to have_button("Submit")
    
  end

  private

  def mock_admin
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user)
                                                .and_return(admin)
  end
end
