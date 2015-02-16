require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) {
    Category.create(name: "movies")
  }

  it "is valid" do
    expect(category).to be_valid
  end

  it "is not valid without a name" do
    category.name = nil
    expect(category).to_not be_valid
  end

  it "can have many events" do
    category.events.create(
                            title: "The Hobbit",
                            date: "Mar 25, 2015",
                            approved: true,
                            description: "Hobbit movie 3"
                            )
    category.events.create(
                            title: "Frozen",
                            date: "Mar 25, 2015",
                            approved: true,
                            description: "Elsa and Anna"
                            )
    expect(category.events.count).to eq 2
    expect(category.events.map(&:title)).to eq(["The Hobbit", "Frozen"])
  end
end
