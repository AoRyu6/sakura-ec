class OrdersController < ApplicationController
  def create
    current_cart.order!
    redirect_to root_path, notice: '注文を受け付けました。メール内容をご確認ください。'
  end
end
