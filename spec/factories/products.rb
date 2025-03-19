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
FactoryBot.define do
  factory :product do
    name { 'MyString' }
    description { 'MyText' }
    price_before_tax { 1 }
  end
end
