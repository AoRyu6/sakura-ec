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
#  row_order      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :product do
    name { Faker::Food.fruits }
    published { false }

    trait :published do
      price { Faker::Number.between(from: 1, to: 10000) }
      description { Faker::Food.description }
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/product.png')) }
      published { true }
    end
  end
end
