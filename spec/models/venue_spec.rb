require "rails_helper"

RSpec.describe Venue, type: :model do
  let(:venue) {
    Venue.create(name: "Red Rocks Amphitheater", location: "Denver")
  }

  it "is valid" do
    expect(venue).to be_valid
  end

  it "is not valid without a name" do
    venue.name = nil
    expect(venue).to_not be_valid
  end

  it "is not valid without a location" do
    venue.location = nil
    expect(venue).to_not be_valid
  end
  
end
