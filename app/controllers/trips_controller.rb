class TripsController < ApplicationController
  before_filter :current_admin?, only: [:index, :destroy, :edit, :update]
  before_filter :authorized_user?, only: [:show, :new, :create]

  def show
    @trip = Trip.where(id: params[:id]).first
  end

  def index
  end

  def new
    @rates = [["Choose a city", nil]] + Rate.all.order(:id).map{|rate| [rate.city_name, rate.id]}
    @trip_types = [["Select Service Type", nil],["From airport (Curbside Pick-up)", 1], ["From airport (Greet and meet Domestic)", 2], ["From airport (Greet and meet International)", 3], ["To Airport", 4], ["Chicago to/from Illinois", 5], ["Hourly", 6]]    
    @cars = [["Select Car Type", nil]] + Car.all.order(:id).map{|car| ["#{car.name} (#{car.capacity} pax)", car.id]}
    @airports = [["Choose an Airport", nil], ["Chicago O'hare (ORD)", 1], ["Chicago Midway (MDW)", 2]]
    @hours = [["How Many Hours", nil], ["2:00", 2], ["2:30", 2.5], ["3:00", 3], ["3:30", 3.5], ["4:00", 4], ["4:30", 4.5], ["5:00", 5], ["5:30", 5.5], ["6:00", 6], ["6:30", 6.5], ["7:00", 7], ["7:30", 7.5], ["8:00", 8], ["8:30", 8.5], ["9:00", 9], ["9:30", 9.5], ["10:00", 10], ["10:30", 10.5], ["11:00", 11], ["11:30", 11.5], ["12:00", 12], ["13:00", 13], ["14:00", 14], ["15:00", 15], ["16:00", 16], ["17:00", 17], ["18:00", 18], ["19:00", 19], ["20:00", 20], ["21:00", 21], ["22:00", 22], ["23:00", 23], ["24:00", 24]]
    @passengers = [["Number of passengers", nil], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6]]
    @trip = Trip.new(params_from_generator.merge({ contact_name: current_user.name, contact_phone: current_user.phone, contact_email: current_user.email}))
  end
  
  def new_non_user
    @rates = [["Choose a city", nil]] + Rate.all.order(:id).map{|rate| [rate.city_name, rate.id]}
    @trip_types = [["Select Service Type", nil],["From airport (Curbside Pick-up)", 1], ["From airport (Greet and meet Domestic)", 2], ["From airport (Greet and meet International)", 3], ["To Airport", 4], ["Chicago to/from Illinois", 5], ["Hourly", 6]]    
    @cars = [["Select Car Type", nil]] + Car.all.order(:id).map{|car| ["#{car.name} (#{car.capacity} pax)", car.id]}
    @airports = [["Choose an Airport", nil], ["Chicago O'hare (ORD)", 1], ["Chicago Midway (MDW)", 2]]
    @hours = [["How Many Hours", nil], ["2:00", 2], ["2:30", 2.5], ["3:00", 3], ["3:30", 3.5], ["4:00", 4], ["4:30", 4.5], ["5:00", 5], ["5:30", 5.5], ["6:00", 6], ["6:30", 6.5], ["7:00", 7], ["7:30", 7.5], ["8:00", 8], ["8:30", 8.5], ["9:00", 9], ["9:30", 9.5], ["10:00", 10], ["10:30", 10.5], ["11:00", 11], ["11:30", 11.5], ["12:00", 12], ["13:00", 13], ["14:00", 14], ["15:00", 15], ["16:00", 16], ["17:00", 17], ["18:00", 18], ["19:00", 19], ["20:00", 20], ["21:00", 21], ["22:00", 22], ["23:00", 23], ["24:00", 24]]
    @passengers = [["Number of passengers", nil], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6]]
    curren_params = params_from_generator.merge(current_user ? { contact_name: current_user.name, contact_phone: current_user.phone, contact_email: current_user.email} : {})
    @trip = Trip.new(current_params)
    render "new"
  end
  
  def non_user_create
    @trip = Trip.new(trip_params)
    @car = Car.where(id: @trip.car_id).first
    if @trip.trip_type == 6
      @trip.price = @car.hourly_rate * @trip.hours.to_f
    else
      @trip.price = Rate.calculate(trip_params, @car.price_ratio)
    end

    @trip.price += 4 if @trip.trip_type <= 3

    if @trip.save
      flash[:notice] = "Thank you for booking a ride with us. One of our representatives will call you regarding the payment."
      redirect_to @trip
    else
      flash[:warning] = "Please make sure that you fill out all the required fields!" 
      @rates = [["Choose a city", nil]] + Rate.all.order(:id).map{|rate| [rate.city_name, rate.id]}
      @trip_types = [["Select Service Type", nil],["From airport (Curbside Pick-up)", 1], ["From airport (Greet and meet Domestic)", 2], ["From airport (Greet and meet International)", 3], ["To Airport", 4], ["Chicago to/from Illinois", 5], ["Hourly", 6]]    
      @cars = [["Select Car Type", nil]] + Car.all.order(:id).map{|car| ["#{car.name} (#{car.capacity} pax)", car.id]}
      @airports = [["Choose an Airport", nil], ["Chicago O'hare (ORD)", 1], ["Chicago Midway (MDW)", 2]]
      @hours = [["How Many Hours", nil], ["2:00", 2], ["2:30", 2.5], ["3:00", 3], ["3:30", 3.5], ["4:00", 4], ["4:30", 4.5], ["5:00", 5], ["5:30", 5.5], ["6:00", 6], ["6:30", 6.5], ["7:00", 7], ["7:30", 7.5], ["8:00", 8], ["8:30", 8.5], ["9:00", 9], ["9:30", 9.5], ["10:00", 10], ["10:30", 10.5], ["11:00", 11], ["11:30", 11.5], ["12:00", 12], ["13:00", 13], ["14:00", 14], ["15:00", 15], ["16:00", 16], ["17:00", 17], ["18:00", 18], ["19:00", 19], ["20:00", 20], ["21:00", 21], ["22:00", 22], ["23:00", 23], ["24:00", 24]]
      @passengers = [["Number of passengers", nil], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6]]
      render "new"
    end
  end

  def create
    @trip = Trip.new(trip_params)
    @car = Car.where(id: @trip.car_id).first
    if @trip.trip_type == 6
      @trip.price = @car.hourly_rate * @trip.hours.to_f
    else
      @trip.price = Rate.calculate(trip_params, @car.price_ratio)
    end

    if @trip.save
      flash[:notice] = "Thank you for booking a ride with us. One of our representatives will call you regarding the payment."
      redirect_to @trip
    else
      flash[:warning] = "Please make sure that you fill out all the required fields!" 
      @rates = [["Choose a city", nil]] + Rate.all.order(:id).map{|rate| [rate.city_name, rate.id]}
      @trip_types = [["Select Service Type", nil],["From airport (Curbside Pick-up)", 1], ["From airport (Greet and meet Domestic)", 2], ["From airport (Greet and meet International)", 3], ["To Airport", 4], ["Chicago to/from Illinois", 5], ["Hourly", 6]]    
      @cars = [["Select Car Type", nil]] + Car.all.order(:id).map{|car| ["#{car.name} (#{car.capacity} pax)", car.id]}
      @airports = [["Choose an Airport", nil], ["Chicago O'hare (ORD)", 1], ["Chicago Midway (MDW)", 2]]
      @hours = [["How Many Hours", nil], ["2:00", 2], ["2:30", 2.5], ["3:00", 3], ["3:30", 3.5], ["4:00", 4], ["4:30", 4.5], ["5:00", 5], ["5:30", 5.5], ["6:00", 6], ["6:30", 6.5], ["7:00", 7], ["7:30", 7.5], ["8:00", 8], ["8:30", 8.5], ["9:00", 9], ["9:30", 9.5], ["10:00", 10], ["10:30", 10.5], ["11:00", 11], ["11:30", 11.5], ["12:00", 12], ["13:00", 13], ["14:00", 14], ["15:00", 15], ["16:00", 16], ["17:00", 17], ["18:00", 18], ["19:00", 19], ["20:00", 20], ["21:00", 21], ["22:00", 22], ["23:00", 23], ["24:00", 24]]
      @passengers = [["Number of passengers", nil], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6]]
      render "new"
    end
  end

  def edit
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

  def trip_params
    params.require(:trip).permit(:contact_name, :contact_phone, :contact_email, :number_of_passengers, :pick_up, :drop_off, :pickup_time, :description).merge( current_user ? {user_id: current_user.id} : {}).merge(params_from_generator)
  end
end
