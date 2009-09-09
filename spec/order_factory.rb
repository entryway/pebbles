module OrderFactory
  
  def self.create_order_item(attributes = {})
    default_attributes = {
      :quantity => 1,
      :price => 1.0,
      :adjusted_price => 1.0,
      :weight => 1.0,
      :adjusted_weight => 1.0,
      :product_name => 'product name',
      :drop_ship => true,
      :created_at => '2007-08-29 19:54:26',
      :updated_at => '2007-08-29 19:54:26'
    }
    OrderItem.create! default_attributes.merge(attributes)
  end
  
  def self.create_product(attributes = {})
    default_attributes = {
      :sku => '12V2A',
      :available => true,
      :is_featured => false, 
      :name => 'Pro-Speed Racer, Go!',
      :weight => 1.0,
      :short_description => 'short description',
      :long_description => 'long description',
      :price => 5.50,
      :admin_notes => 'admin notes',   
      :created_at => '2007-08-29 19:54:26',
      :updated_at => '2007-08-29 19:54:26'
    }
    Product.create! default_attributes.merge(attributes)
  end
  
  
  def self.create_order(attributes = {})
    default_attributes = {
       :full_name => 'John User',
       :email => 'john@somewhere.com',
       :order_number => 'E-1234' + rand.to_s,
       :phone_number => '540-232-1212',
       :created_at => '2007-08-29 19:54:26',
       :updated_at => '2007-08-29 19:54:26'      
     }
     Order.create! default_attributes.merge(attributes)
  end
  
  
  
  def self.create_address(attributes = {})
    default_attributes = {
      :address_1 => '756 Sugar Tree Road',
      :address_2 => '',
      :city => 'Floyd,',
      :state => 'Va',
      :is_shipping => false, 
      :postal_code => '24573'
    }
    OrderAddress.create! default_attributes.merge(attributes)
  end
  
end
