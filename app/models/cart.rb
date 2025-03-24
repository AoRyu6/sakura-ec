# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Cart < ApplicationRecord
  include TaxCalculable

  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_price
    cart_items.eager_load(:product).sum { _1.product.price }
  end

  def order!
    order = user.orders.new

    transaction do
      add_order_items_to_order(order)
      if order.order_items.present?
        order.save!
        OrderMailer.order_confirmation(order).deliver_later
        cart_items.destroy_all
      end
    end
  end

  private

  def add_order_items_to_order(order)
    cart_items.eager_load(:product).each do |cart_item|
      order.order_items.new(product: cart_item.product, price: cart_item.product.price)
    end
  end
end
