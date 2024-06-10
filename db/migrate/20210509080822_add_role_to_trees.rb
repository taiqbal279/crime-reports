class AddRoleToTrees < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :role, :integer
    add_column :trees, :breed_desc, :text
    add_column :trees, :garden_desc, :text
  end
end
