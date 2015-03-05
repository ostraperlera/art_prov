require 'csv'
namespace:spree do
	desc "Import products and variants"
	task :import_options => :environment do
		
		CSV.foreach("xls_csv/products_def.csv", :headers => true) do |row|
				product = Spree::Product.find_by(:name => row[2])
				new_option_type = Spree::OptionType.where(:name => row[16]).first_or_create
					new_option_type.update_attributes({
					:name => row[16],
					:presentation => row[16],
					})

					product.option_types << new_option_type
	  
			puts "New OptionType with name #{new_option_type.name}"	

			if row[17].to_s != "" 
				row[17].split(" | ").each do |value|
				new_option_value = Spree::OptionValue.where(:name => value).first_or_create
					new_option_value.update_attributes({
						:name => value,
						:presentation => value,
						:option_type_id => new_option_type.id
					})
			end
			else 
				puts "Row is empty"
			end
			end
		end
end	
