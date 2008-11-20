class StoresController < ApplicationController
  
  def index
    unless params[:zipcode] == nil
      @stores = Store.find(:all, :origin => params[:zipcode],
                                  :within => 100, 
                                  :order => 'distance') 
      @map = Store.map_stores(params[:zipcode], @stores)                         
    end
  rescue Exception => err
    flash[:notice] = "Invalid Zipcode." + err.message
    redirect_to :action => :index
  end
  
end   