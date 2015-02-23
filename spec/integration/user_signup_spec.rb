require "rails_helper"

describe "the user signup" do
  include Capybara::DSL

  before(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it "with valid signup information and account activation" do
    visit root_path
    click_link("Sign up")

    expect do
      post users_path, user: { full_name: "Steve Jobs",
                               display_name: "stevejobs",
                               email: "steve@jobs.com",
                               password: "password",
                               password_confirmation: "password"
                             }
    end.to change { User.count }

    expect(ActionMailer::Base.deliveries.size).to eq(1)
    user = assigns(:user)
    expect(user.activated?).to be_falsey
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_link_or_button("Log in")
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Check your email")
    get edit_account_activation_path(user.activation_token, email: user.email)
    expect(user.reload.activated?).to be_truthy
  end
end
