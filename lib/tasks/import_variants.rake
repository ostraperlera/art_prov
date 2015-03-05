require 'csv'
namespace:spree do
	desc "Import products and variants"
	task :import_variants => :environment do


		CSV.foreach("xls_csv/variants_def.csv", :headers => true) do |row|

				product = Spree::Product.find_by(:name => row[1])
				puts "Selected product #{product.id}"
				option_type = Spree::OptionType.where(:name => row[13]).first_or_create
				option_type.update_attributes({
					:name => row[13],
					:presentation => row[13]
				})
				option_value = Spree::OptionValue.where(:name => row[11]).first_or_create
				option_value.update_attributes({
					:name => row[11],
					:presentation => row[11],
					:option_type_id => option_type.id
					})
				puts "Selected option_value #{option_value.id}"
				variant = Spree::Variant.where(:sku => row[7]).first_or_initialize
					variant.update_attributes({
					:price => row[2],
					:cost_price => row[2],
					:weight => row[3],
					:depth => row[4],
					:width => row[5],
					:height => row[6],
					:sku => row[7],
					:product_id => product.id,
					:stock_items_count => row[8],
					:tax_category_id => "1"
					})
				variant.save
				variant.option_values << option_value
	 
			 if row[12] != nil	
				option_value = Spree::OptionValue.where(:name => row[12]).first_or_create
				option_type = Spree::OptionType.where(:name => row[14]).first_or_create
				option_type.update_attributes({
					:name => row[14],
					:presentation => row[14]
				})

				option_value.update_attributes({
					:name => row[12],
					:presentation => row[12],
					:option_type_id => option_type.id
					
				})
				variant.option_values << option_value
			 end
		end
		end
end	
