require 'csv'
namespace :item do
  desc "Create CSV Files for Models"
  task :upload  => :environment do
    csv_source = Rails.root.join("lib", "csv", "quarbani.csv")
		puts csv_source.inspect
    CSV.foreach(csv_source, :headers => true) do |row|
			["live_weight", "color", "gender", "teeth", "checked_by_vet", "vaccinated", "district"].each do |item_name|
				puts row[item_name]
			
			end
			cow = Tree.new
      cow.tree_id= row['tag_number']
      cow.breed_name = row['breed']
      cow.is_cattle = true
			cow.save
			["live_weight", "color", "gender", "teeth", "checked_by_vet", "vaccinated", "district"].each do |item_name|
				ItemDescription.create(item_name: item_name, description: row[item_name], tree_id: cow.id)
			end
    
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('trees')
    ActiveRecord::Base.connection.reset_pk_sequence!('item_descriptions')
  end
end