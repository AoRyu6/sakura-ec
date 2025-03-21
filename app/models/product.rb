# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  description      :text             default(""), not null
#  name             :string           not null
#  price_before_tax :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Product < ApplicationRecord
  has_one_attached :image

  ACCEPTED_CONTENT_TYPES = %w[image/png image/jpeg image/gif image/tiff].freeze

  validates :name, presence: true
  validates :price_before_tax, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'は0以上の値にしてください' }
  validates :image, content_type: ACCEPTED_CONTENT_TYPES, size: { less_than: 25.megabytes }
end
