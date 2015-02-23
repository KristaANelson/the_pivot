require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "account_activation" do

    it "creates the email" do
      user = create(:user)
      user.activation_token = User.new_token
      mail = UserMailer.account_activation(user)
      expect(mail.subject).to eq("Hubstub: Account activation")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@hubstub.us"])
      expect(mail.body.encoded).to match(user.full_name)
      expect(mail.body.encoded).to match(user.activation_token)
      expect(mail.body.encoded).to match(CGI::escape(user.email))
    end

  end

  describe "password_reset" do
  end

end
