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

  xit "can have many events" do
  end
end
