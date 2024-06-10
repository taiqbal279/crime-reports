class CreateCommunityAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :community_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end
