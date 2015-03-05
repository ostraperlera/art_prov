Spree::Image.class_eval do
  attachment_definitions[:attachment][:styles] = {
	  :mini => '100x100#', # thumbs under image
  	:small => '261x261#', # images on category view
		:product => '445x650#', # full product image
		:large => '1024x1024#' # light box image
	}
end
