class AdminsController < ApplicationController
  def menu
    @past_trips = Trip.where("pickup_time < ?", Time.now).order(:pickup_time => :desc)
    @future_trips = Trip.where("pickup_time > ?", Time.now).order(:pickup_time)
  end

  def index
    
  end 
end