class CreateExtraCharges < ActiveRecord::Migration
  def change
    create_table :extra_charges do |t|
      t.belongs_to :trip
      t.string :description
      t.float :price
      t.timestamps
    end
  end
end
