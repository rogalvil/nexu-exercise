require 'rails_helper'

RSpec.describe CarModel, type: :model do
  it 'is valid with valid attributes' do
    car_model = build(:car_model)
    expect(car_model).to be_valid
  end

  it 'is invalid without a name' do
    car_model = build(:car_model, name: nil)
    expect(car_model).not_to be_valid
  end

  it 'is invalid with a duplicate name within the same brand' do
    brand = create(:brand)
    create(:car_model, brand:, name: 'Corolla')
    duplicate_model = build(:car_model, brand:, name: 'Corolla')
    expect(duplicate_model).not_to be_valid
  end

  it 'is valid with a duplicate name across different brands' do
    create(:car_model, brand: create(:brand, name: 'Toyota'), name: 'Corolla')
    car_model = build(:car_model, brand: create(:brand, name: 'Honda'), name: 'Corolla')
    expect(car_model).to be_valid
  end

  it 'updates the brand\'s average price after saving' do
    brand = create(:brand)
    create(:car_model, brand:, average_price: 200_000)
    create(:car_model, brand:, average_price: 400_000)

    brand.reload
    expect(brand.average_price).to eq(300_000.0)
  end

  it 'recalculates the brand\'s average price when a car model is updated' do
    brand = create(:brand)
    car_model = create(:car_model, brand:, average_price: 200_000)

    car_model.update(average_price: 400_000)
    brand.reload

    expect(brand.average_price).to eq(400_000.0)
  end

  it 'updates the brand\'s average price after a car model is destroyed' do
    brand = create(:brand)
    car_model1 = create(:car_model, brand:, average_price: 200_000)
    create(:car_model, brand:, average_price: 400_000)

    brand.reload
    expect(brand.average_price).to eq(300_000.0)

    car_model1.destroy
    brand.reload

    expect(brand.average_price).to eq(400_000.0)
  end

  context 'when creating a new car model' do
    let(:brand) { create(:brand) }

    it 'is valid with average_price less than 100,000' do
      car_model = build(:car_model, brand:, average_price: 50_000)
      expect(car_model).to be_valid
    end

    it 'is valid with average_price equal to or greater than 100,000' do
      car_model = build(:car_model, brand:, average_price: 100_000)
      expect(car_model).to be_valid
    end
  end

  context 'when updating an existing car model' do
    let(:brand) { create(:brand) }
    let(:car_model) { create(:car_model, brand:, average_price: 100_000) }

    it 'is invalid if the average_price is updated to less than 100,000' do
      car_model.average_price = 90_000
      expect(car_model).not_to be_valid
      expect(car_model.errors[:average_price]).to include('must be greater than or equal to 100000')
    end

    it 'is valid if the average_price is updated to 100,000 or more' do
      car_model.average_price = 120_000
      expect(car_model).to be_valid
    end
  end
end
