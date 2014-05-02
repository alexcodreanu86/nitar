require 'spec_helper'

describe Rate do
   it "has a valid factory" do
    expect(FactoryGirl.create(:rate)).to be_valid 
  end


  context "#calculate" do 
  
    before :each do 
      @rate = FactoryGirl.create(:rate)
    end

    it "returns proper rate for chicago trip for sedan" do 
      @params = {trip_type: 5, car_type: 1, city_id: @rate.id}
      @chicago_sedan = Rate.calculate(@params)
      expect(@chicago_sedan).to be @rate.chicago_price 
    end

    it "returns proper rate for chicago suv trip" do 
      @params = {trip_type: 5, car_type: 2, city_id: @rate.id}
      @chicago_suv = Rate.calculate(@params)
      expect(@chicago_suv).to be (@rate.chicago_price * 1.2).to_i
    end

    it "returns proper rate for chicago luxury car trip" do 
      @params = {trip_type: 5, car_type: 3, city_id: @rate.id}
      @chicago_suv = Rate.calculate(@params)
      expect(@chicago_suv).to be (@rate.chicago_price * 1.3).to_i
    end

    it "returns proper rate for airport O'Hare curb pickup" do 
      @params = {trip_type: 1 ,airport: 1 ,  car_type: 1, city_id: @rate.id}
      @chicago_o_hare = Rate.calculate(@params)
      expect(@chicago_o_hare).to be @rate.o_hare_price
    end

    it "returns proper rate for midway airport curb pickup" do 
      @params = {trip_type: 1 ,airport: 2 ,  car_type: 1, city_id: @rate.id}
      @chicago_midway = Rate.calculate(@params)
      expect(@chicago_midway).to be @rate.midway_price
    end

    it "returns proper rate for o'hare greet domestic" do 
      @params = {trip_type: 2,airport: 1 ,  car_type: 1, city_id: @rate.id}
      @chicago_o_hare = Rate.calculate(@params)
      expect(@chicago_o_hare).to be @rate.o_hare_price + 30
    end

    it "returns proper rate for o'hare greet domestic" do 
      @params = {trip_type: 3,airport: 1 ,  car_type: 1, city_id: @rate.id}
      @chicago_o_hare = Rate.calculate(@params)
      expect(@chicago_o_hare).to be @rate.o_hare_price + 45
    end
  end
end
