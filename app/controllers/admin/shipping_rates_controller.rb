module Admin
  
  
class ShippingRatesController < ApplicationController
    layout 'admin'
    require_role "admin"
  
    # GET /shipping_rates
    def index
      @shipping_rates = ShippingRate.find(:all)

      respond_to do |format|
        format.html # index.rhtml
      end
    end

    # GET /shipping_rates/1
    # GET /shipping_rates/1.xml
    def show
      @shipping_rate = ShippingRate.find(params[:id])
      
      respond_to do |format|
        format.html # show.rhtml
      end
    end

    # GET /shipping_rates/new
    def new
      puts params
      
      @shipping_rate = ShippingRate.new
    end

    # GET /shipping_rates/1;edit
    def edit
      @shipping_rate = ShippingRate.find(params[:id])
    end

    # POST /shipping_rates
    def create
      @shipping_rate = ShippingRate.new(params[:product])

      respond_to do |format|
        if @shipping_rate.save
          flash[:notice] = 'You have just created a new product, continue adding information below or move on..'
        else
          flash[:notice] = 'There were errors:'
        end
      end
    end

    # PUT /shipping_rates/1
    # PUT /shipping_rates/1.xml
    def update
      @shipping_rate = ShippingRate.find(params[:id])

      respond_to do |format|
        if @shipping_rate.update_attributes(params[:shipping_rate])
          flash[:notice] = 'shipping_rate was successfully updated.'
          format.html { redirect_to shipping_rates_url }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    # DELETE /shipping_rates/1
    # DELETE /shipping_rates/1.xml
    def destroy
      @shipping_rate = ShippingRate.find(params[:id])

      respond_to do |format|
        format.html { redirect_to shipping_rates_url }
      end
    end
end


end
