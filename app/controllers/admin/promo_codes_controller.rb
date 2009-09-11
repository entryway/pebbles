module Admin
  
  class PromoCodesController < ApplicationController
    layout 'admin'
    require_role 'admin'
  
    def index
      @promo_codes = PromoCode.find(:all, :order => 'name')
    end
  
    def new
      @promo_code = PromoCode.new
    end
  
    def create
      @promo_code = PromoCode.new(params[:promo_code])
      @promo_code.code = @promo_code.code.upcase 
      
      respond_to do |format|
        if @promo_code.save
          flash[:notice] = 'Promo Code was successfully created.'
          format.html { redirect_to admin_promo_codes_url }
        else
          format.html { render :action => "new" }
        end
      end
    end
    
    def edit
      @promo_code = PromoCode.find(params[:id])
    end
   
    def update
      @promo_code = PromoCode.find(params[:id])

       respond_to do |format|
         if @promo_code.update_attributes(params[:promo_code])
           flash[:notice] = 'Promo Code was successfully updated.'
           format.html { redirect_to admin_promo_codes_url }
         else
           flash[:notice] = 'Error editing.'
           format.html { render :action => "update" }
         end
       end
    end
    
    def destroy
      @promo_code = PromoCode.find(params[:id])
      @promo_code.destroy

      respond_to do |format|
        format.html { redirect_to admin_promo_codes_url }
        format.xml  { head :ok }
      end
    end
    
  end
  
end