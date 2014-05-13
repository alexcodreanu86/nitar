class AdminsController < ApplicationController
  def menu
    @past_trips = Trip.where("pickup_time < ?", Time.now)
    @future_trips = Trip.where("pickup_time > ?", Time.now)
  end

  def index
    
  end 
end