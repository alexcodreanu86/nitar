class TripsController < ApplicationController
  before_filter :current_admin?, only: [:index, :destroy]
  before_filter :authorized_user?, only: [:show, :new]

  def show
  end

  def index
  end

  def new
  end
  
  def new_from_generator
    @rates = [["Choose a city", -1]] + Rate.all.order(:id).map{|rate| [rate.city_name, rate.id]}
    @trip_types = [["Select Service Type", -1],["From airport (Curbside Pick-up)", 1], ["From airport (Greet and meet Domestic)", 2], ["From airport (Greet and meet International)", 3], ["To Airport", 4], ["Chicago to/from Illinois", 5], ["Hourly", 6]]    
    @cars = [["Select Car Type", -1]] + Car.all.order(:id).map{|car| ["#{car.name} (#{car.capacity} pax)", car.id]}
    @airports = [["Choose an Airport", 0], ["Chicago O'hare (ORD)", 1], ["Chicago Midway (MDW)", 2]]
    @hours = [["How Many Hours", -1], ["2:00", 2], ["2:30", 2.5], ["3:00", 3], ["3:30", 3.5], ["4:00", 4], ["4:30", 4.5], ["5:00", 5], ["5:30", 5.5], ["6:00", 6], ["6:30", 6.5], ["7:00", 7], ["7:30", 7.5], ["8:00", 8], ["8:30", 8.5], ["9:00", 9], ["9:30", 9.5], ["10:00", 10], ["10:30", 10.5], ["11:00", 11], ["11:30", 11.5], ["12:00", 12], ["13:00", 13], ["14:00", 14], ["15:00", 15], ["16:00", 16], ["17:00", 17], ["18:00", 18], ["19:00", 19], ["20:00", 20], ["21:00", 21], ["22:00", 22], ["23:00", 23], ["24:00", 24]]
    @passengers = [["Number of passengers", -1], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6]]
    @trip = Trip.new(params_from_generator)
    render "new"
  end
  
  def non_user_create

  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  protected

  def authorized_user?
    current_admin? || (current_user && current_user.id == params[:user_id])
  end

  def params_from_generator
    params.permit(:trip_type, :airport, :rate_id, :car_id, :hours)
  end
end
