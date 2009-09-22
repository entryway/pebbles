module Pebbles::Admin::ProductsHelper
  def add_discount_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :quantity_discounts, 
      :partial => '/admin/products/wholesale/quantity_discount',
      :object => QuantityDiscount.new
    end
  end
end
