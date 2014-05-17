class ExtraCharge < ActiveRecord::Base
  belongs_to :trip

  after_save :update_trip_total_price
  after_destroy :update_trip_total_price
  def update_trip_total_price
    self.trip.assign_total_price
  end
end
