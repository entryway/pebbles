module Pebbles
  module Shipping

    def self.included(base)
      base.class_eval do
        helper_method :active_shipping_region_id
        helper_method :active_shipping_region_id=
        helper_method :active_shipping_method_id
        helper_method :active_shipping_method_id=
      end
    end

    def active_shipping_region_id
      if session[:shipping_region_id].nil?
        # set default shipping region
        session[:shipping_region_id] = Region.find(:first).id
      end
      session[:shipping_region_id]
    end
    # grab active region
    def active_shipping_region_id=(region_value)
      session[:shipping_region_id] = region_value
    end

    def active_shipping_method_id
      if session[:shipping_method_id].nil?
        # set default shipping rate
        region_id = active_shipping_region_id
        region = Region.find(region_id)
        method = region.default_shipping_method
        session[:shipping_method_id] = method.id unless method.nil?
      end
      session[:shipping_method_id]
    end
    # HACK: couldn't get active_shipping_method_id=() to work?
    def active_shipping_method_id=(method_value)
      session[:shipping_method_id] = method_value
    end



  end
end
