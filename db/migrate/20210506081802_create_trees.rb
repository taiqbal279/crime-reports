class CreateTrees < ActiveRecord::Migration[5.2]
  def change
    create_table :trees do |t|
      t.integer :breed_id
      t.integer :garden_id
      t.integer :tree_id
      t.text :description
      t.string :flowering_period
      t.text :fertilization
      t.string :harvesting_period
      t.string :packaging_period
      t.string :parcel_period
      t.string :delivery_period

      t.timestamps
    end
  end
end
