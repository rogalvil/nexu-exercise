require 'rails_helper'

RSpec.describe Brand, type: :model do
  it 'is valid with valid attributes' do
    brand = build(:brand)
    expect(brand).to be_valid
  end

  it 'is invalid without a name' do
    brand = build(:brand, name: nil)
    expect(brand).not_to be_valid
  end

  it 'is invalid with a duplicate name' do
    create(:brand, name: 'Toyota')
    duplicate_brand = build(:brand, name: 'Toyota')
    expect(duplicate_brand).not_to be_valid
  end

  it 'has a default average_price of 0' do
    brand = create(:brand)
    expect(brand.average_price).to eq(0.0)
  end

  it 'calculates the average price of its car models' do
    brand = create(:brand)
    create(:car_model, brand:, average_price: 200_000)
    create(:car_model, brand:, average_price: 400_000)

    brand.reload
    expect(brand.average_price).to eq(300_000.0)
  end
end
