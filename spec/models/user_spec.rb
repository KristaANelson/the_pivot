require "rails_helper"

describe User, { type: "model" } do
  it "is invalid without a full name" do
    user = build(:user, full_name: nil)

    expect(user).not_to be_valid
  end

  it "is valid with a full name" do
    user = build(:user)

    expect(user).to be_valid
  end

  it "only takes unique emails" do
    create(:user)
    user = build(:user, email: "john@bobo.com")

    expect(user).not_to be_valid
  end

  it "rejects display names that are too short" do
    user = build(:user, display_name: "a")

    expect(user).not_to be_valid
  end

  it "rejects display name thats too long" do
    user = build(:user, display_name: "ThisDisplayNameHasToooLongRightTooLong")

    expect(user).not_to be_valid
  end

end
