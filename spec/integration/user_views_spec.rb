require "rails_helper"

describe "the user" do
  include Capybara::DSL

  it "sees a Login button on homepage" do
    visit root_path
    expect(page).to have_link("Login")
    expect(page).to_not have_link("Logout")
  end

  it "cannot log in with invalid credentials" do
    visit root_path
    click_link("Login")
    fill_in "session[email]", with: ""
    fill_in "session[password]", with: ""
    click_link_or_button("Log in")

    expect(page).to have_content("Invalid Login")
  end

  it "can see a signup button" do
    visit root_path
    click_link("Login")

    expect(page).to have_link("Create account")
  end

  it "can create an account" do
    visit root_path
    click_link("Login")
    click_link("Create account")
    fill_in "user[full_name]", with: "Robert Smith"
    fill_in "user[display_name]", with: "Bob"
    fill_in "user[email]", with: "bob@email.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button("Create my account!")

    expect(page).to have_content("Account successfully created. You are logged in!")
  end

  it "can login" do
    user = create(:user)

    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button("Log in")

    expect(page).to have_content("Successfully logged in")
  end

  it "sees a Logout button instead of Login " do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end

  it "can log out" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    click_link("Logout")

    expect(page).to have_content("Successfully logged out")
  end
end
