require "rails_helper"
describe Category, type: "model" do

  it "is valid" do
    category = build(:category)
    expect(category).to be_valid
  end

  it "is not valid without a name" do
    category = build(:category, name: nil)
    expect(category).to_not be_valid
  end

  it "can have many events" do
    category = create(:category)
    event1 = create(:event)
    event2 = create(:event, title: "Frozen")

    Categorization.create(category_id: category.id, event_id: event1.id)
    Categorization.create(category_id: category.id, event_id: event2.id)

    expect(category.events.count).to eq 2
    expect(category.events.map(&:title)).to eq(["Blazers vs. Clippers", "Frozen"])
  end
end
