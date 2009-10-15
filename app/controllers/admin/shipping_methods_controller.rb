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
      @region = Region.find(params[:region_id])
      @shipping_method = ShippingMethod.find(params[:id])
    end

    def create
      @region = Region.find(params[:region_id])
      @shipping_method = ShippingMethod.new(params[:shipping_method])
     
      if @shipping_method.save
        flash[:notice] = 'You have just created a new shipping method...'
        redirect_to admin_regions_path
      else
        flash[:notice] = 'There were errors:'
      end
    end

    def update
      @shipping_method = ShippingMethod.find(params[:id])
      if @shipping_method.update_attributes(params[:shipping_method])
        flash[:notice] = "Shipping method #{@shipping_method.name} was successfully updated."
        redirect_to admin_regions_path
      else
        render :action => "edit" 
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
