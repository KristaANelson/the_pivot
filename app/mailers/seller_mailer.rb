class SellerMailer < ApplicationMailer
  def listing_sold_confirmation(seller, buyer, order_items)
    @seller = seller
    @buyer = buyer
    @order_items = order_items
    mail to: @seller.email, subject: "Hubstub: Congrats, your listing has sold!"
  end
end
