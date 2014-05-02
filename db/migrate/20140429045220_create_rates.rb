class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.string :city_name
      t.integer :o_hare_price
      t.integer :midway_price
      t.integer :chicago_price
      
      t.timestamps
    end
  end
end
