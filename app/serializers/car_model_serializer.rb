# frozen_string_literal: true

# Serializer for CarModel
class CarModelSerializer < ActiveModel::Serializer
  attributes :id, :name, :average_price
end
