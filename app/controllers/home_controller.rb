class HomeController < ApplicationController
  def index
    @rates = [["Choose a city", -1]] + Rate.all.order(:city_name).map{|rate| [rate.city_name, rate.id]}
    @trip_types = [["Select Service Type", -1],["From airport (Curbside Pick-up)", 1], ["From airport (Greet and meet Domestic)", 2], ["From airport (Greet and meet International)", 3], ["To Airport", 4], ["Chicago to/from Illinois", 5], ["Hourly", 6]]    
    @cars = [["Select Car Type", -1], ["Sedan (3 pas)", 1], ["Private SUV (6 pax)", 2], ["Luxury Black Car(3 pax)", 3]]
  end
end