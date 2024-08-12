# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BrandsController, type: :request do
  let(:brand) { create(:brand) }
  let(:valid_attributes) { { name: 'Toyota' } }
  let(:invalid_attributes) { { name: '' } }

  describe 'GET /brands' do
    before { create_list(:brand, 3) }

    it 'returns a list of all brands' do
      get '/brands'
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /brands' do
    context 'with valid attributes' do
      it 'creates a new car model' do
        post "/brands/#{brand.id}/models", params: { car_model: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(json['name']).to eq(valid_attributes[:name])
        expect(json['average_price'].to_f.round(2)).to eq(valid_attributes[:average_price].to_f.round(2))
      end
    end

    context 'with invalid attributes' do
      it 'returns an error' do
        post '/brands', params: { brand: invalid_attributes }
        expect(json['errors']).to include('Name can\'t be blank')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when brand name already exists' do
      before { create(:brand, name: 'Toyota') }

      it 'returns an error' do
        post '/brands', params: { brand: valid_attributes }
        expect(json['errors']).to include('Name has already been taken')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
