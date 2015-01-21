require "rails_helper"

describe User, { type: "model" } do
  it "is invalid without a full name" do
    user = User.new(full_name: nil)
    expect(user).not_to be_valid
  end

  it "is valid with a full name" do
    user = User.new(full_name: "Bob Pendergast", password: "test")
    expect(user).to be_valid
  end

  it "only takes unique emails" do
    User.create(full_name:        "Bob Smith",
                       password:  "test",
                       email:     "no@no.com")
    user2 = User.new(full_name: "Jane Smith",
                     password:  "cheese",
                     email:     "no@no.com")
    expect(user2).not_to be_valid
  end

  it "rejects display names that are too short" do
    user = User.new(full_name:    "Bob",
                    password:     "test",
                    email:        "no@no.com",
                    display_name: "a")
    expect(user).not_to be_valid
  end

  it "accepts a display name thats between 2 and 32" do
   user = User.new(full_name:     "Bob",
                    password:     "test",
                    email:        "no@no.com",
                    display_name: "Test Username")
   expect(user).to be_valid
  end

  it "rejects display name thats too long" do
    user = User.new(full_name:    "Bob",
                    password:     "test",
                    email:        "no@no.com",
                    display_name: "ThisDisplayNameHasToBeTooLongRightTooLong")
    expect(user).not_to be_valid
  end

end

