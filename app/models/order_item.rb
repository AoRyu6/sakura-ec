# == Schema Information
#
# Table name: order_items
#
#  id             :bigint           not null, primary key
#  price_cents    :integer          not null
#  price_currency :string           default("JPY"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  order_id       :bigint           not null
#  product_id     :bigint           not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  scope :default_order, -> { order(created_at: :asc) }
end
