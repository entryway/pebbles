
class PromoCode < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :code

  attr_accessor :message

  SUCCESS_MESSAGE = "Promo Code successfully applied, enjoy."
  NOT_APPLIED_MESSAGE = "Promo Code not applied."
  MINIMUM_AMOUNT_MESSAGE = "Your order did not reach the minimum amount required of "
  INVALID_MESSAGE = "This is not a valid promo code, please check and reapply."

  # apply a specific promo code to an order
  def self.apply(order, promo_code)
    begin
      promo_code = promo_code.upcase
      promo = PromoCode.find_by_code(promo_code)
    rescue
      order.promo_code = ''
      order.free_shipping = false
      order.promo_discount = ''
      order.save!
    end
    if promo
      promo.apply(order)
    else
      promo = PromoCode.new
      promo.message = INVALID_MESSAGE
    end

    promo
  end

  # apply the promo code to a particular order
  def apply(order)
    self.message = INVALID_MESSAGE

    if order.sub_total >= self.minimum_order_amount
      # order is the minimum amount
      if self.percent_discount && self.percent_discount > 0
        discount = self.calculate_percent_discount(order)
      else
        discount = self.dollar_discount
      end
      discount ||= 0
      self.message = SUCCESS_MESSAGE

      if order
        order.promo_code = self.code.upcase
        order.free_shipping = true if self.free_shipping
        order.promo_discount = discount
        order.save(false)
      end
    else
      self.message = minimum_amount_required_message
    end

    self.message
  end

  def calculate_percent_discount(order)
    (self.percent_discount / 100) * order.product_total
  end

  def minimum_amount_required_message
    MINIMUM_AMOUNT_MESSAGE + '$' + self.minimum_order_amount.to_s
  end


end
