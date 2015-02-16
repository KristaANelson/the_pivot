require "rails_helper"

describe Venue, type: :model do

  it "is valid" do
    venue = create(:venue)
    expect(venue).to be_valid
  end

  it "is not valid without a name" do
    venue = build(:venue, name: nil)
    expect(venue).to_not be_valid
  end

  it "is not valid without a location" do
    venue = build(:venue, location: nil)
    expect(venue).to_not be_valid
  end

  it "can have many events" do

    # category = create(:category)
    venue = create(:venue)
    event1 = create(:event)
    event2 = create(:event, title: "Frozen")
    venue.events << event1
    venue.events << event2
    expect(venue.events.count).to eq 2
    expect(venue.events.map(&:title)).to eq(["Blazers vs. Clippers", "Frozen"])
  end

end
