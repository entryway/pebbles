class OrderDeliveryStatus
  NOT_SHIPPED = 1
  SHIPPED = 2
  RETURNED = 3
  DELAYED = 4

  LIST = [["Not Shipped", OrderDeliveryStatus::NOT_SHIPPED],
					["Shipped", OrderDeliveryStatus::SHIPPED],
					["Returned", OrderDeliveryStatus::RETURNED],
          ["Delayed", OrderDeliveryStatus::DELAYED]
          ]

  def self.status(id)
    case id
    when 1
      return "Not Shipped"
    when 2
      return "Shipped"
    when 3
      return "ReturnedD"
    when 4
      return "Delayed"
    end
  end
end
