require "rails_helper"

describe Item, type: "model"  do

  it "is invalid without a title" do
    item = build(:item, title: nil)

    expect(item).not_to be_valid
  end

  it "is invalid without a description" do
    item = build(:item, description: nil)

    expect(item).not_to be_valid
  end

  it "is invalid without a price" do
    item = build(:item, unit_price: nil)

    expect(item).not_to be_valid
  end

  it "is valid with all three attributes" do
    item = build(:item)

    expect(item).to be_valid
  end

  it "cannot have a blank title" do
    item = build(:item, title: "")

    expect(item).not_to be_valid
  end

  it "cannot have a blank description" do
    item = build(:item, title: "")

    expect(item).not_to be_valid
  end

  it "cannot have a duplicate title" do
    create(:item)
    item = build(:item, title: "pizza")

    expect(item).not_to be_valid
  end

  it "cannot have a price of 0" do
    item = build(:item, unit_price: 0)

    expect(item).not_to be_valid
  end

  it "cannot have a price of 1.1" do
    item = build(:item, unit_price: 1.1)

    expect(item).not_to be_valid
  end

  it "has active items in scope" do
    item = create(:item)

    expect(Item.active.first).to eq(item)
  end

  it "has inactive items in scope" do
    item = create(:item, active: false)

    expect(Item.inactive.first).to eq(item)
  end
end
