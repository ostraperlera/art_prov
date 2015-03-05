require 'csv'
namespace :spree do
	desc "Import and assign categories"
	task :import_taxons => :environment do

		CSV.foreach("xls_csv/products_def.csv", :headers => true) do |row|

				product = Spree::Product.find_by(name: row[2])
				
				if row[12] != nil 
					row[12].split(", ").each do |taxon|
						if Spree::Taxon.find_by(:name => taxon)
							new_taxon = Spree::Taxon.find_by(:name => taxon)
						else 
							new_taxon =	Spree::Taxon.create!(:name => taxon)
						end					
						
						product.taxons << new_taxon
				 		puts "#{product.name} added to taxon #{new_taxon.name}"	
					end
				else 
					puts "Empty row"
				end
		end
	end
end



