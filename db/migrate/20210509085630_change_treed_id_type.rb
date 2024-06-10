class ChangeTreedIdType < ActiveRecord::Migration[5.2]
  def change
    change_column :trees, :tree_id, :string
  end
end
