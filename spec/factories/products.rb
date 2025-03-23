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
    published { false }

    trait :published do
      price_before_tax { Faker::Number.between(from: 1, to: 10000) }
      description { Faker::Food.description }
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/product.png')) }
      published { true }
    end
  end
end
