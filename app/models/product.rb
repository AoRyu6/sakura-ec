# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  description    :text             default(""), not null
#  name           :string           not null
#  price_cents    :integer
#  price_currency :string           default("JPY"), not null
#  published      :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Product < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [600, 600]
  end
  has_many :cart_items, dependent: :destroy

  ACCEPTED_CONTENT_TYPES = %w[image/png image/jpeg image/gif image/tiff].freeze

  monetize :price_cents, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'は0以上の値にしてください' }

  validates :name, presence: true
  validates :image, content_type: ACCEPTED_CONTENT_TYPES, size: { less_than: 25.megabytes }
  with_options if: :published? do
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, message: 'は0以上の値にしてください' }
    validates :description, presence: true
    validate :image_attached
  end

  scope :default_order, -> { order(created_at: :desc, id: :desc) }
  scope :published, -> { where(published: true) }

  private

  def image_attached
    errors.add(:image, 'を添付してください') unless image.attached?
  end
end
