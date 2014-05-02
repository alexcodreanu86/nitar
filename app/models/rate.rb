class Rate < ActiveRecord::Base

  def self.calculate(params, ratio)
    @rate = self.where(id: params[:city_id]).first

    if (1..4).cover? params[:trip_type].to_i
      @price = params[:airport].to_i == 1 ? @rate.o_hare_price : @rate.midway_price
      if params[:trip_type].to_i  == 2
        @price += 30
      elsif params[:trip_type].to_i == 3
        @price += 45
      end
    else
      @price = @rate.chicago_price
    end

    @price *= ratio

    @price.to_i
  end
end
