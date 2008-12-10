class OrderReport < Ruport::Controller
  
  stage :list

  def setup
    start_date = options.start_date.empty? ? 
                  Date.parse('2007-01-01') : 
                  Date.parse(options.start_date)
    end_date = options.end_date.empty? ? 
                  Date.today :
                  Date.parse(options.end_date)
    # create range string to grab orders
    range = "created_at #{(start_date..end_date).to_s(:db)}"
    
    self.data = Order.report_table(:all, 
                                   :only => ['created_at', 'order_number', 'full_name',
                                             'business', 'product_cost', 'shipping_cost'],
                                   :methods => [:total],
                                   :include =>
                                     { 
                                       :shipping_address => { :only => ['state', 'country'] },
                                     #  :products => { :only => 'sku' },
                                       :order_items => { :only => ['product_name', 'quantity'] },
                                       :transactions => { :only => 'success' }
                                     },
                                   :order => 'created_at DESC',
                                   :conditions => ["state = ? AND #{range}",
                                                   "fulfilled"])
    if self.data.size > 0
      self.data.reorder('created_at', 'order_number', 'full_name', 'business', 'shipping_address.state',
                  'shipping_address.country', 'product_cost', 'shipping_cost', 
                  'total','order_items.quantity', 'products.sku', 
                  'order_items.product_name')
    end
    self.data.rename_columns('created_at' => 'Order Date', 'order_number' => 'Order Number',
                        'full_name' => 'Full Name',
                        'business' => 'Company', 'product_cost' => 'SubTotal',
                        'shipping_cost' => 'Shipping Cost',
                        'products.sku' => 'Sku', 
                        'total' => 'Total',
                        'order_items.product_name' => 'Product Name', 
                        'order_items.quantity' => 'Quantity',
                        'shipping_address.country' => 'Country',
                        'shipping_address.state' => 'State')

  end

  formatter :html do
    build :list do
      output << '<div class="gt-table-controls clearfix">'
      output << data.to_html(:class => 'gt-list-table')
      output << '</div>'
    end
  end
  
  formatter :pdf do
    build :list do
      pad(10) { add_text "Orders" }
      draw_table data
    end
  end
  
  formatter :csv do
    build :list do
      output << data.to_csv
    end
  end
  
end
