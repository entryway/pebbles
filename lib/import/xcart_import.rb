class ActiveRecord::Base
  def self.establish_legacy_connection
    self.establish_connection(
       :adapter => "mysql", 
       :host => "localhost",
       :username => "root",
       :password => "tussy2",
       :database => "floydcountystore",
       :encoding => 'utf8'
     )
  end
end

#maps to product
class XProduct < ActiveRecord::Base
  set_table_name 'xcart_products'
  set_primary_key 'productid'
  establish_legacy_connection
  has_many :x_variants, :foreign_key => 'productid'
  has_many :x_classes, :foreign_key => 'productid'
  has_many :x_options, :through => :x_classes
  has_one :x_quick_prices, :foreign_key => 'productid'
  has_one :x_pricing, :through => :x_quick_prices
end

class XQuickPrices < ActiveRecord::Base
  set_table_name 'xcart_quick_prices'
  establish_legacy_connection
  belongs_to :x_products, :foreign_key => 'product_id'
  belongs_to :x_pricing, :foreign_key => 'priceid'
end

class XPricing < ActiveRecord::Base
  set_table_name 'xcart_pricing'
  set_primary_key 'priceid'
  establish_legacy_connection
  has_one :x_quick_prices, :foreign_key => 'priceid'
end 

# maps to product_options
class XClass < ActiveRecord::Base
  set_table_name 'xcart_classes'
  set_primary_key 'classid'
  establish_legacy_connection
  belongs_to :x_products, :foreign_key => 'productid'
  has_many :x_variants, :through => :x_variant_items
  has_many :x_options, :foreign_key => 'classid'
end

# maps to product_option_selection
class XOption < ActiveRecord::Base
  set_table_name 'xcart_class_options'
  set_primary_key 'optionid'
  establish_legacy_connection
  belongs_to :x_class, :foreign_key => 'classid'
  has_many :x_variant_items, :foreign_key => 'optionid'
  has_many :x_variants, :through => :x_variant_items
end

class XVariant < ActiveRecord::Base
  set_table_name 'xcart_variants'
  set_primary_key 'variantid'
  establish_legacy_connection
  belongs_to :x_product, :foreign_key => 'productid'
  belongs_to :x_option, :foreign_key => 'optionid'
end

class XVariantItem < ActiveRecord::Base
  set_table_name 'xcart_variant_items'
  establish_legacy_connection
  belongs_to :x_variant, :foreign_key => 'variantid'
  belongs_to :x_option, :foreign_key => 'optionid'
end

XProduct.all.each do |xp|
  p = Product.new
  p.sku = xp.productcode
  p.name = xp.product
  p.short_description = xp.descr
  p.weight = xp.weight
  #p.vendor_id
  p.price = xp.x_pricing.price
  p.long_description = xp.fulldescr
  p.available = xp.avail
  p.save!
  xp.x_classes.each do |xc|
    po = ProductOption.new
    po.name = xc.classname
    po.description = xc.classtext
    po.selection_type = 1
    p.product_options << po
    xc.x_options.each do |xo|
      ps = ProductOptionSelection.new
      ps.name = xo.option_name
      ps.list_order = xo.orderby
      po.product_option_selections << ps
    end
  end    
end