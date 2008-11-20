class Region < ActiveRecord::Base
  has_many :shipping_methods
  
   # couldn't get :first to work right with has_finder
  #has_finder :default_method, 
  #           :conditions => { :default_selection => true }
  
  def default_shipping_method
    shipping_methods.find(:first, :conditions => { :default_selection => true })
  end
  
end
