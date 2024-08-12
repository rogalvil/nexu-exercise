# frozen_string_literal: true

# Model for car models
class CarModel < ApplicationRecord
  belongs_to :brand

  validates :name, presence: true, uniqueness: { scope: :brand_id }
  validates :average_price, numericality: { greater_than_or_equal_to: 100_000 }, on: :update

  after_save :update_brand_average_price
  after_destroy :update_brand_average_price

  private

  def update_brand_average_price
    brand.recalculate_average_price!
  end
end
