# frozen_string_literal: true

# Serializer for Brand
class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name, :average_price
end
