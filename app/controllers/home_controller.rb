class HomeController < ApplicationController
  def index
    @rates = [["Choose a city", -1]] + Rate.all.map{|rate| [rate.city_name, rate.id]}
    @trip_types = [["Select Service Type", -1],["From airport (Curbside Pick-up)", 1], ["From airport (Greet and meet Domestic)", 2], ["From airport (Greet and meet International)", 3], ["To Airport", 4], ["Chicago to/from Illinois", 5], ["Hourly", 7]]    
  end
end