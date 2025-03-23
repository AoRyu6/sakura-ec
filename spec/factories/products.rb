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
FactoryBot.define do
  factory :product do
    name { Faker::Food.fruits }
  end
end
