FactoryBot.define do
  factory :car_model do
    sequence(:name) { |n| "Car Model Name #{n}" }
    average_price { 175_000 }
    association :brand
  end
end
