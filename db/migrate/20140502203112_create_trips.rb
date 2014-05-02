class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.belongs_to :user
      t.belongs_to :car
      t.belongs_to :rate
      t.string :pick_up
      t.string :drop_of
      t.string :description
      t.integer :trip_type
      t.integer :airport
      t.float :hours
      t.integer :price

      t.timestamps
    end
  end
end
