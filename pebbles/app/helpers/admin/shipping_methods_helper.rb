module Admin::ShippingMethodsHelper
	def add_fulfillment_link(name)
	  link_to_function name do |page|
			page.insert_html :bottom, :fulfillment_codes, 
							         :partial => 'fulfillment_code',
							         :object => FulfillmentCode.new
		end
	end
end