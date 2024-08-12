# frozen_string_literal: true

# Controller for Car Models
class CarModelsController < ApplicationController
  before_action :brand, only: %i[index create]
  before_action :car_models, only: %i[index]
  before_action :car_model, only: %i[update]

  def index
    @car_models = @car_models.where('average_price > ?', params[:greater].to_i) if params[:greater].present?
    @car_models = @car_models.where('average_price < ?', params[:lower].to_i) if params[:lower].present?
    render json: @car_models, each_serializer: CarModelSerializer
  end

  def create
    @car_model = @brand.car_models.new(car_model_params)

    if @car_model.save
      render json: @car_model, status: :created, serializer: CarModelSerializer
    else
      render json: { errors: @car_model.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @car_model.update(car_model_params)
      render json: @car_model, serializer: CarModelSerializer
    else
      render json: { errors: @car_model.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def brand
    @brand = params[:brand_id] ? Brand.find_by(id: params[:brand_id]) : nil
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Brand not found' }, status: :not_found
  end

  def car_models
    @car_models = @brand ? @brand.car_models : CarModel.all
  end

  def car_model
    @car_model = CarModel.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Car model not found' }, status: :not_found
  end

  def car_model_params
    params.require(:car_model).permit(:average_price)
  end
end
