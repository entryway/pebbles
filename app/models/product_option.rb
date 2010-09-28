class ProductOption < ActiveRecord::Base
  has_many :product_option_selections,
           :order => 'list_order, name'
  has_many :sorted_options, :class_name => 'ProductOptionSelection',
           :order => 'list_order'

  has_many :product_option_instances, :dependent => :destroy
  has_many :products, :through => :product_option_instances
  default_scope :order => :id

  accepts_nested_attributes_for :product_option_selections, :allow_destroy => true,
                                :reject_if => proc { |attributes| attributes['name'].blank? }



  # Options for selection type
  DROP_DOWN_LIST = 1
  RADIO_BUTTON = 2
  TEXT_INPUT = 3

  LIST = [["Drop Down List", ProductOption::DROP_DOWN_LIST],
					["Radio Button", OrderDeliveryStatus::SHIPPED],
					["Text Input", OrderDeliveryStatus::RETURNED]
          ]

  def self.to_text(id)
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
