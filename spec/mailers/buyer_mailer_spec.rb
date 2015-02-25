require "rails_helper"

RSpec.describe BuyerMailer, :type => :mailer do
  describe "purchase_confirmation" do

    it "creates the buyer confirmation email" do
      buyer = create(:user)
      seller = create(:user)
      item = create(:item, user: seller)
      order = Order.create(user: buyer)
      OrderItem.create(item_id: item.id, order_id: order.id)
      mail = BuyerMailer.purchase_confirmation(order).deliver_now
      expect(mail.subject).to eq("Hubstub: Order Confirmation")
      expect(mail.to).to eq([buyer.email])
      expect(mail.from).to eq(["noreply@hubstub.us"])
      expect(mail.body.encoded).to match(buyer.full_name)
    end
  end
end
