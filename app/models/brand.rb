# frozen_string_literal: true

# Model for brands
class Brand < ApplicationRecord
  has_many :car_models, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :average_price, numericality: { greater_than_or_equal_to: 0 }

  before_save :calculate_average_price

  def recalculate_average_price!
    calculate_average_price
    save
  end

  private

  def calculate_average_price
    self.average_price = car_models.any? ? car_models.average(:average_price).to_f : 0
  end
end
