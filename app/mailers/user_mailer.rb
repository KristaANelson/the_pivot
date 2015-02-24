class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Hubstub: Account activation"
  end

  def purchase_confirmation(order)
    @order = order
    mail to: order.buyer.email, subject: "Hubstub: Order Confirmation"
  end

  def listing_sold_confirmation(seller, order)
    @seller = seller
    @order = 
    mail to: seller.email, subject: "Hubstub: Congrats, your listing has sold!"
  end
end
