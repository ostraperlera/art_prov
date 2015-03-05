require 'csv'
namespace :spree do
	desc "Import product properties"
	task :import_properties => :environment do

		CSV.foreach("xls_csv/products_def.csv", :headers => true) do |row|

				product = Spree::Product.find_by(name: row[2])
				if row[15] != nil 
					product.set_property("Materiales", row[15])		
					puts "created Property with name #{product.product_properties.first[:value]}  and id #{product.product_properties.first[:id]}"
      end
		end
	end
end	
