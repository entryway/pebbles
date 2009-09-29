module Pebbles::Admin::ProductsHelper
	def add_discount_link(name)
	  link_to_function name do |page|
			page.insert_html :bottom, :quantity_discounts, 
							         :partial => '/admin/products/wholesale/quantity_discount',
							         :object => QuantityDiscount.new
		end
	end
	
	def setup_option(product)
    returning(product) do |p|
      p.product_options.build
    end
  end
  
  def setup_selection(option)
    returning(option) do |o|
      3.times do 
        o.product_option_selections.build
      end
    end
  end
  
  def add_another_link?(object, object_name)
    if object.new_record?
      "<a href='#' class=\"add-object\">add another #{object_name}</a>"
    end
  end
	  
end