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

  def calculate
    @price = Rate.calculate(params)
    if request.xhr? 
      render json: {price: @price}
    end
  end

end