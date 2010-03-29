class OrderType
  ALL = 0
  WEB = 1
  EBAY = 2

  LIST = [["ALL", OrderType::ALL,
           "WEB", OrderType::EBAY,
           "EBAY", OrderType::WEB]]

  def self.type(id)
    case id
    when ALL
      return "ALL"
    when WEB
      return "WEB"
    when EBAY
      return "EBAY"
    end
  end
end
