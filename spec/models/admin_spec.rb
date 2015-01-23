require "rails_helper"

RSpec.describe Admin, type: "model" do
  it "is valid by default" do
    admin = build(:admin)

    expect(admin).to be_valid
  end

  it "is invalid without a full name" do
    admin = build(:admin, full_name: nil)

    expect(admin).not_to be_valid
  end

  it "only is valid with a unique email" do
    create(:admin)
    admin = build(:admin, email: "nope@nope.com")

    expect(admin).not_to be_valid
  end

  it "rejects display names that are too short" do
    admin = build(:admin, display_name: "a")

    expect(admin).not_to be_valid
  end

  it "rejects display names that are too long" do
    admin = build(:user, display_name: "ThisDisplayNameHasTooLongRightTooLong")

    expect(admin).not_to be_valid
  end

  it "expects the admin to be an admin" do
    admin = build(:admin)

    expect(admin.admin?).to be_truthy
  end
end
