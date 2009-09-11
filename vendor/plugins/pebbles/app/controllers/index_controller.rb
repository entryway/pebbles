
class IndexController < ApplicationController
 # caches_page :index, :shipping_information, :return_policy, :about,
 #              :contact_us, :charity

  def index
    @featured_products = Product.find(:all, :conditions => { :is_featured => true })
    render :layout => 'splash'
  end
  
  def send_contact
    ContactNotifier.deliver_contact_confirmation(params[:name], params[:email],
                                                 params[:phone], params[:extension],
                                                 params[:comment]) 
  end
  
  def about; end
  def charity; end
  def return_policy; end
  def shipping_information; end

   
end
