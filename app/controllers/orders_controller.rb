class OrdersController < ApplicationController
  def index
    @pagy, @orders = pagy(current_user.orders.preload(:order_items, :products).default_order)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    current_cart.order!
    redirect_to root_path, notice: '注文を受け付けました。メール内容をご確認ください。'
  end
end
