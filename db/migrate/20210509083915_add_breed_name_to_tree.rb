class AddBreedNameToTree < ActiveRecord::Migration[5.2]
  def change
    add_column :trees, :breed_name, :string
  end
end
