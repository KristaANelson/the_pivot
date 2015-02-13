require "rails_helper"

describe Item, type: "model"  do

  it "is invalid without a price" do
    item = build(:item, unit_price: nil)

    expect(item).not_to be_valid
  end

  it "is invalid without a seat" do
    item = build(:item, seat: nil)

    expect(item).not_to be_valid
  end

  it "is invalid without a row" do
    item = build(:item, row: nil)

    expect(item).not_to be_valid
  end

  it "is invalid without a section" do
    item = build(:item, section: nil)

    expect(item).not_to be_valid
  end

  it "is valid with all three attributes" do
    item = create(:item)

    expect(item).to be_valid
  end

  it "cannot have a price of 0" do
    item = build(:item, unit_price: 0)

    expect(item).not_to be_valid
  end

  it "cannot have a price of 1.1" do
    item = build(:item, unit_price: 1.1)

    expect(item).not_to be_valid
  end

  it "sold defaults to false" do
    item = create(:item)

    expect(item.sold).to eq(false)
  end

  it "has pending items in scope" do
    item = create(:item, pending: true)

    expect(Item.pending.first).to eq(item)
  end

  it "has confirmed items in scope" do
    item = create(:item, pending: false)

    expect(Item.confirmed.first).to eq(item)
  end

  it "has a user" do
    user = create(:user)
    item = create(:item, user_id: user.id)

    expect(item.user.id).to eq(user.id)
  end
end
