class CreateCrimeReports < ActiveRecord::Migration[5.2]
  def change
    create_table :crime_reports do |t|
      t.datetime :datetime
      t.string :date
      t.string :time
      t.string :day
      t.string :month
      t.string :year
      t.string :primary_type
      t.string :description
      t.string :location_description
      t.string :arrest
      t.string :domestic
      t.string :beat
      t.string :district
      t.integer :community_area_id

      t.timestamps
    end
  end
end
