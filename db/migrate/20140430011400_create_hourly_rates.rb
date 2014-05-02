class CreateHourlyRates < ActiveRecord::Migration
  def change
    create_table :hourly_rates do |t|
      t.string :car_type
      t.integer :price_per_hour
      
      t.timestamps
    end
  end
end
