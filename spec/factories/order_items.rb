FactoryBot.define do
  factory :order_item do
    order { nil }
    product { nil }
    price { 1 }
  end
end
