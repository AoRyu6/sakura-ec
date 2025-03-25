# == Schema Information
#
# Table name: shipping_addresses
#
#  id             :bigint           not null, primary key
#  city           :string           not null
#  postal_code    :string           not null
#  recipient_name :string           not null
#  street_address :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  prefecture_id  :integer          not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_shipping_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :prefecture

  validates :city, presence: true
  validates :postal_code, presence: true
  validates :recipient_name, presence: true
end
