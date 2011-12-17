
class PayPal_IPN_Controller < ApplicationController

  def paypal_ipn
    notify = Paypal::Notification.new(request.raw_post)



    # order = Order.find(notify.item_id)
    #
    # if notify.acknowledge
    #   begin
    #
    #     if notify.complete? and order.total == notify.amount
    #       order.status = 'success'
    #
    #       shop.ship(order)
    #     else
    #       logger.error("Failed to verify Paypal's notification, please investigate")
    #     end
    #
    #   rescue => e
    #     order.status = 'failed'
    #     raise
    #   ensure
    #     order.save
    #   end
    # end
    #
    # render :nothing
  end

end


