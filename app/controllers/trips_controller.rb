class TripsController < ApplicationController
  before_filter :authorize_admin, only: [:destroy, :edit, :update, :toggle_payment, :confirm_with_customer, :send_confirmation]
  before_filter :authorize_user, only: [:index, :show, :new, :create]
  before_filter :authorize_non_user, only: [:non_user_show]

  def show
    @trip = Trip.where(id: params[:id]).first
    unless @trip 
      unauthorized_user
    end
  end

  def index
    @user = User.where(id: params[:user_id]).first
    @trips = @user.trips.order(:pickup_time => :desc)
  end

  def new
    set_form_variables
    @trip = Trip.new(params_from_generator.merge({ contact_first_name: current_user.first_name, contact_last_name: current_user.last_name, contact_phone: current_user.phone, contact_email: current_user.email}))
  end

  def non_user_show
    @trip = Trip.where(id: params[:id]).first
    render "show"
  end
  
  def new_non_user
    set_form_variables
    current_params = params_from_generator.merge(current_user ? { contact_name: current_user.name, contact_phone: current_user.phone, contact_email: current_user.email} : {})
    @trip = Trip.new(current_params)
    render "new"
  end
  
  def non_user_create
    @trip = Trip.new(trip_params)
    @car = Car.where(id: @trip.car_id).first
    if @car
      if @trip.trip_type == 6
        @trip.base_price = @car.hourly_rate * @trip.hours.to_f
      else
        @trip.base_price = Rate.calculate_base(trip_params, @car.price_ratio)
      end
    end

    if @trip.save
      # email = SpartanMailer.new_quote_request(@trip)
      # email.deliver
      flash[:notice] = "Thank you for booking a ride with us. One of our representatives will call you regarding the payment."
      redirect_to non_user_show_path @trip
    else
      flash[:alert] = "Please make sure that you fill out all the required fields!" 
      set_form_variables
      render "new"
    end
  end

  def create
    @trip = Trip.new(trip_params.merge(user_id: current_user.id))
    @car = Car.where(id: @trip.car_id).first
    if @car
      if @trip.trip_type == 6
        @trip.base_price = @car.hourly_rate * @trip.hours.to_f
      else
        @trip.base_price = Rate.calculate_base(trip_params, @car.price_ratio)
      end
    end
    if @trip.save
      flash[:notice] = "Thank you for booking a ride with us. One of our representatives will call you regarding the payment."
      redirect_to user_trip_path(@trip.user_id, @trip.id)
      # email = SpartanMailer.new_quote_request(@trip.id)
      # email.deliver
    else
      flash[:alert] = "Please make sure that you fill out all the required fields!" 
      set_form_variables
      render "new"
    end
  end

  def edit
    set_form_variables
    @trip = Trip.where(id: params[:id]).first
  end

  def update
    @trip = Trip.where(id: params[:id]).first
    @trip.update(update_trip_params)
    if @trip.save
      flash[:notice] = "Trip Successfully updated."
      redirect_to non_user_show_path @trip
    else
      flash[:alert] = "Please make sure that you fill out all the required fields!" 
      set_form_variables
      render "edit"
    end
  end

  def destroy
    @trip = Trip.where(id: params[:id]).first
    @trip.destroy
    redirect_to admin_menu_path
  end

  def toggle_payment
    @trip = Trip.where(id: params[:id]).first
    @trip.payment_information = !@trip.payment_information
    @trip.save
    redirect_to :back
  end
  
  def confirm_with_customer
    @trip = Trip.where(id: params[:id]).first
  end

  def send_confirmation
    @trip = Trip.where(id: params[:id]).first
    @message = params[:admin_message]
    @trip.is_confirmed = true
    @trip.save
    flash[:notice] = "Sent confirmation to #{@trip.contact_email}!"
    redirect_to non_user_show_path @trip
    SpartanMailer.send_customer_confirmation(@message, @trip).deliver
  end

  protected

  def authorize_user
    unless current_admin? || (current_user && current_user.id == params[:user_id].to_i)
      unauthorized_user
    end
  end

  def authorize_non_user
    @trip = Trip.where(id: params[:id]).first
    unless current_admin? || @trip.booker_ip == request.remote_ip
      unauthorized_user
    end
  end

  def params_from_generator
    params.permit(:trip_type, :airport, :rate_id, :car_id, :hours, :user_id)
  end

  def trip_params
    params.require(:trip).permit(:contact_first_name, :contact_last_name, :contact_phone, :contact_email, :number_of_passengers, :pick_up, :drop_off, :pickup_time, :description, :confirmed_agreement).merge(params_from_generator).merge({number_of_passengers: params[:number_of_passengers], booker_ip: request.remote_ip})
  end

  def update_trip_params
    params.require(:trip).permit(:contact_first_name, :contact_last_name, :contact_phone, :contact_email, :number_of_passengers, :pick_up, :drop_off, :pickup_time, :description, :driver_information).merge(params_from_generator).merge({number_of_passengers: params[:number_of_passengers]})
  end

  def set_form_variables
    @rates = [["Choose a city", nil]] + Rate.all.order(:id).map{|rate| [rate.city_name, rate.id]}
    @trip_types = [["Select Service Type", nil],["From airport (Curbside Pick-up)", 1], ["From airport (Greet and meet Domestic)", 2], ["From airport (Greet and meet International)", 3], ["To Airport", 4], ["Chicago to/from Illinois", 5], ["Hourly", 6]]    
    @cars = [["Select Car Type", nil]] + Car.all.order(:id).map{|car| ["#{car.name} (#{car.capacity} pax)", car.id]}
    @airports = [["Choose an Airport", nil], ["Chicago O'hare (ORD)", 1], ["Chicago Midway (MDW)", 2]]
    @hours = [["How Many Hours", nil], ["2:00", 2.0], ["2:30", 2.5], ["3:00", 3.0], ["3:30", 3.5], ["4:00", 4.0], ["4:30", 4.5], ["5:00", 5.0], ["5:30", 5.5], ["6:00", 6.0], ["6:30", 6.5], ["7:00", 7.0], ["7:30", 7.5], ["8:00", 8.0], ["8:30", 8.5], ["9:00", 9.0], ["9:30", 9.5], ["10:00", 10.0], ["10:30", 10.5], ["11:00", 11], ["11:30", 11.5], ["12:00", 12.0], ["13:00", 13.0], ["14:00", 14.0], ["15:00", 15.0], ["16:00", 16.0], ["17:00", 17.0], ["18:00", 18.0], ["19:00", 19.0], ["20:00", 20.0], ["21:00", 21.0], ["22:00", 22.0], ["23:00", 23.0], ["24:00", 24.0]]
    @passengers = [["Number of passengers", nil], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6]]
  end
end
