FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "Brand Name #{n}" }
    average_price { 150_000 }
  end
end
