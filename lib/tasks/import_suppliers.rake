require 'csv'
namespace:spree do
	desc "Import vendors and their system users from a csv file"
	task :import_suppliers => :environment do

	supplier_count = 0
	address_count = 0 
	users_count = 0 
	
	CSV.foreach("xls_csv/suppliers_def.csv", :headers => true) do |row|
		supplier = Spree::Supplier.where(id: row[0]).first_or_create
			supplier.update_attributes({
			:name => row[1],
			:slug => row[2],
			:email => row[3],
			:bio => row[4],
			:url => row[5],
			:commission_percentage => row[6],
			:created_at => row[7],
			:active => true
		})
		supplier_count += 1
		puts "Supplier created: #{supplier.name}" 


		supplier.update_attributes({
				address_attributes: {
				:first_name => row[15],
				:last_name => row[16],
				:address1 => row[8],
				:city => row[9],
				:zipcode => row[13],
				:phone => row[12],
				:company => row[10],
				:country => Spree::Country.find_by(:iso3 => row[11]),
				:state => Spree::State.find_by(:abbr => row[14])
				}
		})
		address_count += 1

		user = supplier.users.where(:email => row[3]).first_or_create
			user.update_attributes({
				:email => row[3],
				:password => row[15],
				:password_confirmation => row[15]
			})
			users_count += 1

		end
			puts "#{supplier_count} suppliers created"
			puts "#{address_count} addresses created"
			puts "#{users_count} users created"
	end
end	
