class OutOfStockOption < ActiveRecord::Base
  
  belongs_to :product
  has_many :out_of_stock_option_selections, :dependent => :destroy
  
  def self.out_of_stock?(product_id, product_option_selection_ids)
    # first find all the product_options with that product_id and include
    # and preload the selections
    out_of_stock_options = 
      OutOfStockOption.find(:all,
                            :conditions => { :product_id => product_id },
                            :include => :out_of_stock_option_selections )             
    selection_found = false
    
    # now generate an array of product_option_selection_ids for each out_of_stock
    # product and compare with the passed selection array.
    out_of_stock_options.each do |item|
      out_of_stock_option_selection_ids = Array.new
      item.out_of_stock_option_selections.each do |selection| 
        out_of_stock_option_selection_ids << 
              selection.product_option_selection_id.to_s
      end
      if out_of_stock_option_selection_ids.sort == 
          product_option_selection_ids.sort
        selection_found = true
      end
    end
    
    selection_found
  end
  
  # return all the out of stock selections as a concated string
  def out_of_stock_selection_string
    out_of_stock_option_selections.collect { |x| x.product_option_selection.name + ', ' }
  end

end
