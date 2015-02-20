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

  it "is not valid without an unique name" do
    venue1 = create(:venue)
    venue2 = build(:venue, name: venue1.name.upcase)
    expect(venue2).to_not be_valid
  end

  it "is not valid without a location" do
    venue = build(:venue, location: nil)
    expect(venue).to_not be_valid
  end

  it "can have many events" do
    venue = create(:venue)
    event1 = create(:event)
    event2 = create(:event)
    venue.events << event1
    venue.events << event2
    expect(venue.events.count).to eq 2
    expect(venue.events.map(&:title)).to eq([event1.title, event2.title])
  end

  it "finds the lat and long when it saves" do
    venue = create(:venue)

    expect(venue.lat).to eq(39.7392358)
    expect(venue.long).to eq(-104.990251)
  end

  it "finds the timezone offset when it saves" do
    venue = create(:venue)

    expect(venue.time_zone_offset).to eq(-25200)
  end
end
