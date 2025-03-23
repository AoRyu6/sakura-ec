# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  description      :text             default(""), not null
#  name             :string           not null
#  price_before_tax :integer
#  published        :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Product < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [600, 600]
  end
  has_many :cart_items, dependent: :destroy

  ACCEPTED_CONTENT_TYPES = %w[image/png image/jpeg image/gif image/tiff].freeze

  validates :name, presence: true
  validates :price_before_tax, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: 'は0以上の値にしてください' }
  validates :image, content_type: ACCEPTED_CONTENT_TYPES, size: { less_than: 25.megabytes }

  scope :default_order, -> { order(created_at: :desc, id: :desc) }
  # TODO: - このスコープを使って、公開中の商品のみを取得するように修正する
  scope :published, -> {}
end
