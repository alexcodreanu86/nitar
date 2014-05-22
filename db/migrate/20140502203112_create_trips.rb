class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.belongs_to :user
      t.belongs_to :car
      t.belongs_to :rate
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_phone
      t.string :contact_email
      t.boolean :payment_information, default: false
      t.boolean :is_confirmed, default: false
      t.string :booker_ip
      t.integer :number_of_passengers
      t.string :pick_up
      t.string :drop_off
      t.datetime :pickup_time
      t.text :description
      t.string :driver_information
      t.integer :trip_type
      t.integer :airport
      t.float :hours
      t.integer :base_price
      t.float :total_price

      t.timestamps
    end
  end
end
