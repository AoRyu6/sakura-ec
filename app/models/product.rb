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
  validates :name, presence: true
  validates :description, presence: true
  validates :price_before_tax, presence: true, numericality: { greater_than_or_equal_to: 0, message: 'は0以上の値にしてください' }
end
