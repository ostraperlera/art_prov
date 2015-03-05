require 'csv'
namespace:spree do
	desc "Import products and variants"
	task :import_master_variants => :environment do

products_count = 0

	CSV.foreach("xls_csv/products_def.csv", :headers => true) do |row|
				product = Spree::Product.find_by(:name => row[2])
				puts "Product name: #{product.name}"
				product.master.update_attributes({
					:stock_items_count => row[14]
						})
		
			puts "Created #{products_count} in total"
			products_count  += 1

		end

		end
end	
