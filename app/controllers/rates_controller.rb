class RatesController < ApplicationController

  def show
  end

  def index
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def hourly_quote
    @rate = Car.find(params[:car_id]).hourly_rate
    @price = (@rate * params[:hours].to_f).to_i
    if request.xhr?
      render json: {price: @price}
    end
  end

  def calculate
    @car_ratio = Car.where(id: params[:car_id]).select(:price_ratio).first.price_ratio
    @price = Rate.calculate(params, @car_ratio)
    if request.xhr? 
      render json: {price: @price}
    end
  end

end