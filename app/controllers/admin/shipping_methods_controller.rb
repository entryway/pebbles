module Admin
  
  
class ShippingMethodsController < ApplicationController
    layout 'admin'
    require_role "admin"

    def index
      @shipping_mehtods = ShippingMethod.find(:all)

      respond_to do |format|
        format.html # index.rhtml
      end
    end

    def show
      @shipping_method = ShippingMethod.find(params[:id])
      
      respond_to do |format|
        format.html # show.rhtml
      end
    end

    def new
      @region = Region.find(params[:region_id])
      @shipping_method = ShippingMethod.new
    end

    def edit
      @shipping_method = ShippingMethod.find(params[:id])
      @region = params[:region_id]
      if @shipping_method.flat_rate_shipping
        @flat_rate_shipping = FlatRateShipping.find(@shipping_method.flat_rate_shipping)
      end
    end

    def create
      @region = Region.find(params[:region_id])
      @flat_rate_shipping = FlatRateShipping.new(params[:flat_rate_shipping])
      @shipping_method = ShippingMethod.new(params[:shipping_method])

      @region.shipping_methods << @shipping_method
      @shipping_method.flat_rate_shipping = @flat_rate_shipping
      
      # respond_to do |format|
      #   if @shipping_method.save
      flash[:notice] = 'You have just created a new shipping method...'
      redirect_to admin_regions_path
      #   else
      #     flash[:notice] = 'There were errors:'
      #   end
      # end
    end

    def update
      @shipping_method = ShippingMethod.find(params[:id])
      unless @shipping_method.flat_rate_shipping
        # create a new one if there were issues with relation
        @shipping_method.flat_rate_shipping = FlatRateShipping.create
      end
            
      respond_to do |format|
        if @shipping_method.update_attributes(params[:shipping_method])
          @shipping_method.flat_rate_shipping.update_attributes(params[:flat_rate_shipping])
          flash[:notice] = "Shipping method #{@shipping_method.name} was successfully updated."
          format.html { redirect_to admin_regions_path }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    def destroy
      shipping_method = ShippingMethod.find(params[:id])
      
      shipping_method.destroy
      
      respond_to do |format|
        format.html { redirect_to admin_regions_path }
      end
    end
    
end


end
