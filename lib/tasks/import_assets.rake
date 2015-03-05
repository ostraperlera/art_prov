require 'csv'
namespace:spree do
	desc "Import images"
	task :import_master_assets => :environment do

		CSV.foreach("xls_csv/products_def.csv", :headers => true) do |row|
			variant = Spree::Variant.find_by(:sku => row[13])
				if File.exist?(row[18])
					variant.images.create!(:attachment => File.open(row[18]), :alt => row[2])
					puts "Image for #{variant.sku} created"	
				else 
					puts "File #{row[18]} does not exist"
				end
				if row[19] != nil
					image_count = 0
					row[19].split(",").each do |path|
						if File.exist?(path)
							variant.images.create!(:attachment => File.open(path), :alt => row[2])
							image_count +=1
							puts "Created #{image_count} image(s)"
						else
							puts "File #{path} doesnt exist"
						end
					end	
				end
		end
	end 

	desc "Import variant images"
	task :import_variant_assets => :environment do

		CSV.foreach("xls_csv/variants_def.csv", :headers => true) do |row|
			variant = Spree::Variant.where(:sku => row[7]).first_or_create
			if row[9] != nil
				variant.images.create!(:attachment => File.open(row[9]), :alt => row[1])
				puts "Image created for variant #{row[7]}"
			end
		end	
	end
end

