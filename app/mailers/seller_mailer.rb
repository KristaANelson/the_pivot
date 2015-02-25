class SellerMailer < ApplicationMailer
  def listing_sold_confirmation(seller, buyer, items)
    @seller = seller
    @buyer = buyer
    @items = items
    mail to: @seller.email, subject: "Hubstub: Congrats, your listing has sold!"
  end
end
