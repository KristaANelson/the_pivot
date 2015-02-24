class BuyerMailer < ApplicationMailer
  def purchase_confirmation(order)
    @order = order
    mail to: order.buyer.email, subject: "Hubstub: Order Confirmation"
  end
end
