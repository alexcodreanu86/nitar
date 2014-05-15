class AdminsController < ApplicationController
  def menu
    @past_trips = Trip.where("pickup_time < ?", Time.now).order(:pickup_time => :desc)
    @future_trips = Trip.where("pickup_time > ?", Time.now).order(:pickup_time)
  end

  def index
  end 
  
  def new
    @admin = User.new
  end

  def create
    @admin = User.new(admin_params.merge(password: "newadmin", password_confirmation: "newadmin"))
    if @admin.save
      flash[:notice] = "#{@admin.name} added as admin succesfully. Temporary password is: 'newadmin'"
      redirect_to @admin
    else
      flash[:alert] = "Failed creating new admin please make sure that all the fields are filled out."
      render "new"
    end
  end

  protected

  def admin_params
    params.require(:admin).permit(:email, :phone, :name).merge(is_admin: true)
  end
end
