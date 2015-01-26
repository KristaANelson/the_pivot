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

  it "doesn't need a display name" do
    user = build(:user)

    expect(user).to be_valid
  end

  it "has a correctly formatted email address" do
    user = build(:user, email: "bob.com")

    expect(user).not_to be_valid
  end

  it "has unqiue email addresses" do
    user = create(:user)
    new_user = build(:user, email: user.email.upcase)

    expect(new_user).not_to be_valid
  end

  it "only takes a correctly formated email" do
    user = build(:user, email: "john")

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

  it "answers false when asked if an admin" do
    user = build(:user)

    expect(user.admin?).not_to be_truthy
  end
end
