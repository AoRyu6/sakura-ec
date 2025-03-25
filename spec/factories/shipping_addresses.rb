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
FactoryBot.define do
  factory :shipping_address do
    recipient_name { Faker::Name.name }
    city { Faker::Address.city }
    postal_code { Faker::Address.zip_code }
    street_address { Faker::Address.street_address }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
  end
end
