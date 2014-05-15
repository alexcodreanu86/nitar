class ExtraChargesController < ApplicationController
  before_filter :authorize_admin
  def new
    @trip = Trip.where(id: params[:trip_id]).first
    @extra_charge = ExtraCharge.new
  end

  def create
    @extra_charge = ExtraCharge.new(new_charges_params)
    if @extra_charge.save
      @trip = Trip.where(id: params[:trip_id]).first
      flash[:notice] = "Extra charge of #{@extra_charge.price}$ was added successfully"
      redirect_to user_trip_path(@trip.user_id, @trip.id)
    else
      flash[:alert] = "Did not add extra charge, please make sure you fill out all fields"
      render "new"
    end
  end

  def edit
    @extra_charge = ExtraCharge.where(id: params[:id]).first
  end

  def update
    @extra_charge = ExtraCharge.where(id: params[:id]).first
    @extra_charge.update(update_charges_params)

    if @extra_charge.save
      @trip = @extra_charge.trip
      flash[:notice] = "Extra charge of #{@extra_charge.price}$ was updated successfully"
      redirect_to user_trip_path(@trip.user_id, @trip.id)
    else
      flash[:alert] = "Unable to update the extra charge, please make sure you fill out all fields"
      render "edit"
    end
  end

  def destroy
    @extra_charge = ExtraCharge.where(id: params[:id]).first
    @trip = @extra_charge.trip
    @extra_charge.destroy
    redirect_to user_trip_path(@trip.user_id, @trip.id)
  end

  protected

  def new_charges_params
    params.require(:extra_charge).permit(:description, :price).merge(trip_id: params[:trip_id])
  end
  
  def update_charges_params
    params.require(:extra_charge).permit(:description, :price)
  end
end
