class HourlyRatesController < ApplicationController

  def new
  end

  def show
    @rate = HourlyRate.where(id: params[:id]);
    if request.xhr?
      return @rate
    end
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
    @rate = HourlyRate.where(id: params[:car_type]).first
    @price = (@rate.price_per_hour * params[:hours].to_f).to_i
    if request.xhr?
      render json: {price: @price}
    end
  end

end