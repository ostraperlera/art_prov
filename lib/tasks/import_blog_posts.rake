require 'csv'
namespace:spree do
	desc "Import blog posts"
	task :import_blog_posts => :environment do

products_count = 0

		CSV.foreach("xls_csv/posts_def.csv", :headers => true) do |row|

			post = Spree::BlogEntry.where(:title => row[2]).first_or_create
			post.update_attributes({
				:visible => row[0],
				:permalink => row[1],
				:title => row[2],
				:body => row[3],
				:summary => row[4],
				:author_id => 1,
				:created_at => row[6],
				:published_at => row[7],
			})
			if row[8] != nil && File.exist?(row[8])
			image = Spree::BlogEntryImage.create!({
				:attachment => File.open(row[8]),
					:alt => row[2] 
					})

			post.update_attributes({
				:blog_entry_image => image
			})
			end
		end
		puts "Created #{products_count} product(s)"
	end
end	
