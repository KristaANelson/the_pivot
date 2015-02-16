require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) {
    Category.create(name: "Theater")
  }

  it "is valid" do
    expect(category).to be_valid
  end

  it "is not valid without a name" do
    category.name = nil
    expect(category).to_not be_valid
  end

  it "can have many events" do
    event1 = create(:event, title: "The Hobbit", description: "Hobbit movie 3")
    event2 = create(:event, title: "Frozen", description: "movie about two sisters")

    Categorization.create(category_id: category.id, event_id: event1.id)
    Categorization.create(category_id: category.id, event_id: event2.id)
    expect(category.events.count).to eq 2
    expect(category.events.map(&:title)).to eq(["The Hobbit", "Frozen"])
  end
end
