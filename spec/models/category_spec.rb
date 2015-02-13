require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) {
    Category.create(name: "movies")
  }

  it "is valid" do
    expect(category).to be_valid
  end

  xit "is not valid without a name" do
    category.name = nil
    expect(category).to_not be_valid
  end

  xit "can have many items" do
    category.items.create(
    title: "Green Chili Burrito",
    description: "Amazingly spicey burrito",
    price: 655
    )
    category.items.create(
    title: "Hot n Spicy",
    description: "spicey burrito",
    price: 700
    )
    expect(category.items.count).to eq 2
    expect(category.items.map(&:title)).to eq(["Green Chili Burrito",
      "Hot n Spicy"])
    end
  end
