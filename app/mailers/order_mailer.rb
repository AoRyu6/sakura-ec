class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    mail to: @order.user.email, subject: '注文を受け付けました'
  end
end
