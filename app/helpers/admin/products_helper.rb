module Admin::ProductsHelper
	def add_discount_link(name)
	  link_to_function name do |page|
			page.insert_html :bottom, :quantity_discounts, 
							         :partial => '/admin/products/wholesale/quantity_discount',
							         :object => QuantityDiscount.new
		end
	end
	
	def setup_option(product)
    returning(product) do |p|
      3.times do 
        p.product_options.build
      end
    end
  end
  
  def setup_selection(option)
    returning(option) do |o|
      3.times do 
        o.product_option_selections.build
      end
    end
  end

  def show_option?(option)
    display = @hide_option ? "style=display:none" : ""
    @hide_option = option.new_record?
    return display
  end
  
  def show_selection?(selection)
    display = @hide_selection ? "style=display:none" : ""
    @hide_selection = selection.new_record?
    return display
  end
  
  def add_another_selection_link?(selection)
    if selection.new_record?
      "<td colspan=3><a href='#' class=\"add-selection\">add another selection</a></td>"
    end
  end
	  
end