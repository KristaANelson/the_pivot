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
end
