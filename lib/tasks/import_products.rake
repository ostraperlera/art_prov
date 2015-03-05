require 'csv'
namespace:spree do
	desc "Import products and variants"
	task :import_products => :environment do

products_count = 0

	CSV.foreach("xls_csv/products_def.csv", :headers => true) do |row|

				Spree::Product.create!({
					:name => row[2],
					:description => row[1],
					:available_on => row[5],
					:meta_keywords => row[20],
					:excerpt => row[3],
					:tax_category_id => row[7],
					:shipping_category_id => row[21],
					:price => row[6],
					:cost_price => row[6],
					:weight => row[8],
					:depth => row[9],
					:width => row[10],
					:height => row[11],
					:sku => row[13]
					})
	  
			product = Spree::Product.find_by(:name => row[2])
			puts "New product: #{Spree::Product.find_by(:name => row[2])}"	
			puts "Created #{products_count} in total"
			product.add_supplier!(row[0])
			products_count  += 1

		end
			puts "Created #{products_count} product(s)"
		end
end	
