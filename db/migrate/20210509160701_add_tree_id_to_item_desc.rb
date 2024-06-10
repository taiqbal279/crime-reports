class AddTreeIdToItemDesc < ActiveRecord::Migration[5.2]
  def change
    add_column :item_descriptions, :tree_id, :integer, null: false
  end
end
