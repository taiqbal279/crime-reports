class CreateItemDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :item_descriptions do |t|
      t.string :item_name
      t.text :description

      t.timestamps
    end
  end
end
