class CartItemsController < ApplicationController
  def create
    product = Product.published.find(params.expect(:product_id))
    cart = current_cart

    cart_item = cart.cart_items.new(product_id: product.id)

    if cart_item.save
      redirect_to product, notice: 'カートに商品を追加しました'
    else
      redirect_to product, alert: 'カートに商品を追加できませんでした'
    end
  end
end
