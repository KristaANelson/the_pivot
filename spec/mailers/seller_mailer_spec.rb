require "rails_helper"

RSpec.describe SellerMailer, :type => :mailer do
  describe "listing_sold_confirmation" do

    it "creates the seller confirmation email" do
      buyer = create(:user)
      seller = create(:user)
      item = create(:item, user: seller)
      order = Order.create(user: buyer)
      OrderItem.create(item_id: item.id, order_id: order.id)
      mail = SellerMailer.listing_sold_confirmation(seller, buyer, order).deliver_now
      expect(mail.subject).to eq("Hubstub: Order Confirmation")
      expect(mail.to).to eq([seller.email])
      expect(mail.from).to eq(["noreply@hubstub.us"])
    end
  end
end
