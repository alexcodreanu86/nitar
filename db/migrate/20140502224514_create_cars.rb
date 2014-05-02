class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :name
      t.integer :capacity
      t.float :price_ratio
      t.integer :hourly_rate

      t.timestamps
    end
  end
end
