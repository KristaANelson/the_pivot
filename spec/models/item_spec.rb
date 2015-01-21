require 'rails_helper'

describe Item, :type => :model do

  it 'is invalid without a title' do
    item = Item.new(title: nil)
    expect(item).not_to be_valid
  end

  it 'is invalid without a description' do
    item = Item.new(description: nil)
    expect(item).not_to be_valid
  end

  it 'is invalid without a price' do
    item = Item.new(unit_price: nil)
    expect(item).not_to be_valid
  end

  it 'is valid with all three attributes' do
    item = Item.new(title: "Something",
                    description: "Thing",
                    unit_price: 1)
    expect(item).to be_valid
  end

  it 'cannot have a blank title' do
    item = Item.new(title: "",
                    description: "Thing",
                    unit_price: 1)
    expect(item).not_to be_valid
  end

  it 'cannot have a blank description' do
    item = Item.new(title: "Thing",
                    description: "",
                    unit_price: 1)
    expect(item).not_to be_valid
  end

  it 'cannot have a duplicate title' do
    item = Item.create(title: "Thing",
                       description: "asd",
                       unit_price: "1")
    item = Item.new(title: "Thing",
                    description: "wer",
                    unit_price: 2)
    expect(item).not_to be_valid
  end

  it 'cannot have a price of 0' do
    item = Item.create(title: "Thing",
                       description: "asd",
                       unit_price: 0)
    expect(item).not_to be_valid
  end

  it 'cannot have a price of 1.1' do
    item = Item.new(title: "Thing",
                    description: "asd",
                    unit_price: 1.1)
    expect(item).not_to be_valid
  end


end
