# frozen_string_literal: true

require 'json'

file_path = Rails.root.join('db', 'seeds', 'models.json')
json_data = File.read(file_path)
models = JSON.parse(json_data)

models.each do |model_data|
  brand_attributes = { name: model_data['brand_name'] }

  brand = Brand.find_or_initialize_by(name: brand_attributes[:name]).tap do |b|
    b.update!(brand_attributes)
  end

  car_model_attributes = {
    id: model_data['id'],
    name: model_data['name'],
    average_price: model_data['average_price'],
    brand:
  }

  CarModel.find_or_initialize_by(id: car_model_attributes[:id]).tap do |car_model|
    car_model.update!(car_model_attributes)
  end
rescue ActiveRecord::RecordInvalid => e
  puts "Error inserting or updating record: #{e.message}"
end

puts 'Seed data inserted or updated successfully!'
