# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CarModelsController, type: :request do
  let(:brand) { create(:brand) }
  let!(:car_model) { create(:car_model, brand:, average_price: 300_000) }
  let(:valid_attributes) { { name: 'Corolla', average_price: 350_000 } }
  let(:invalid_attributes) { { name: '', average_price: 50_000 } }

  describe 'GET /brands/:brand_id/car_models' do
    it 'returns all car models for a brand' do
      get "/brands/#{brand.id}/car_models"
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /car_models' do
    it 'returns all car models' do
      get '/car_models'
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
      expect(response).to have_http_status(:ok)
    end

    it 'returns car models with a price greater than a specified value' do
      get '/car_models', params: { greater: 200_000 }
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
      expect(response).to have_http_status(:ok)
    end

    it 'returns car models with a price lower than a specified value' do
      get '/car_models', params: { lower: 400_000 }
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /brands/:brand_id/car_models' do
    context 'with valid attributes' do
      it 'creates a new car model' do
        post "/brands/#{brand.id}/car_models", params: { car_model: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(json['name']).to eq(valid_attributes[:name])
        expect(json['average_price'].to_f.round(2)).to eq(valid_attributes[:average_price].to_f.round(2))
      end
    end

    context 'with invalid attributes' do
      it 'returns an error' do
        post "/brands/#{brand.id}/car_models", params: { car_model: invalid_attributes }
        expect(json['errors']).to include("Name can't be blank")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /car_models/:id' do
    context 'with valid attributes' do
      it 'updates the car model' do
        put "/car_models/#{car_model.id}", params: { car_model: { average_price: 400_000 } }
        car_model.reload
        expect(car_model.average_price).to eq(400_000)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      it 'returns an error if average_price is below 100,000' do
        put "/car_models/#{car_model.id}", params: { car_model: { average_price: 90_000 } }
        expect(json['errors']).to include('Average price must be greater than or equal to 100000')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
