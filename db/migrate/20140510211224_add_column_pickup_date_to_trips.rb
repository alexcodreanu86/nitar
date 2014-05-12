class AddColumnPickupDateToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :pickup_time, :datetime
  end
end
