class ProductOption < ActiveRecord::Base 
  has_many :product_option_selections,
           :order => "list_order, name"
  

  has_many :product_option_instances, :dependent => :delete_all
  has_many :product, :through => :product_option_instances

  # Options for selection type 
  DROP_DOWN_LIST = 1
  RADIO_BUTTON = 2
  TEXT_INPUT = 3

  LIST = [["Drop Down List", ProductOption::DROP_DOWN_LIST],
					["Radio Button", OrderDeliveryStatus::SHIPPED],
					["Text Input", OrderDeliveryStatus::RETURNED]
          ]

  def self.to_s(id)
    case id
    when 1
      return "Drop Down List"
    when 2
      return "Radio Button"
    when 3
      return "Text Input"
    end
  end

end
