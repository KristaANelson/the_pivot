require "rails_helper"

describe Event, type: "model" do

  it "is invalid without a title" do
    event = build(:event, title: nil)

    expect(event).not_to be_valid
  end

  it "is invalid without a date" do
    event = build(:event, date: nil)

    expect(event).not_to be_valid
  end

  it "is invalid without an approval" do
    event = build(:event, approved: nil)

    expect(event).not_to be_valid
  end

  it "is invalid without an image" do
    event = build(:event, image_id: nil)

    expect(event).not_to be_valid
  end

  it "is invalid without an image" do
    event = build(:event, image_id: nil)

    expect(event).not_to be_valid
  end

  it "is valid with all attributes" do
    event = create(:event)

    expect(event).to be_valid
  end

  it "cannot have a blank title" do
    event = build(:event, title: "")

    expect(event).not_to be_valid
  end

  it "cannot have a blank date" do
    event = build(:event, title: "")

    expect(event).not_to be_valid
  end

  it "cannot have a duplicate title" do
    existing_event = create(:event)
    event = build(:event, title: existing_event.title)
    event_up = build(:event, title: existing_event.title.upcase)

    expect(event).not_to be_valid
    expect(event_up).not_to be_valid
  end


  it "uses time time local to event location" do
    event1 = create(:event, start_time: "2000-01-01 17:24:06 UTC")
    event2 = create(:event, start_time: "2000-01-01 17:24:06 UTC")
    venue = create(:venue, location: "Chicago, IL")
    event1.venue = venue

    expect(event1.formatted_time_zone).to eq("11:24 AM")
    expect(event2.formatted_time_zone).to eq("10:24 AM")
  end
end
