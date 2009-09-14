class Store < ActiveRecord::Base
  include GeoKit::Geocoders
    
  has_many :store_images
  acts_as_mappable
  
  def store_image
     store_images[0].public_filename() unless store_images.empty?
  end 
  
  def self.geocode_address(store)
     res = GoogleGeocoder.geocode(store.address + ", " + store.city + ", " + store.state)
     if (res.lng == nil || res.lat == nil)
       return store
     else
     store.lng = res.lng
     store.lat = res.lat
     store
     end
  end
  
  def self.map_stores(zipcode, stores)
    res = GoogleGeocoder.geocode(zipcode)
    @map = GMap.new("map_div")
	  @map.control_init(:large_map => true,:map_type => true)
	  @map.center_zoom_init([res.lat,res.lng],7)
    for store in stores 
	    @map.overlay_init(GMarker.new([store.lat,store.lng],
	                      :title => store.storename, 
	                      :info_window => store.full_address))
    end 
    @map           
  end
  
  def self.paged_stores(page)
    paginate :per_page => 50, :page => page, :order => "storename"
  end
  
  def full_address
    fullAddress = "<div style = \"color:#000000\">" + storename + "<br>" + address + "<br>" + city + ", " + state + "<br>" + zip + "<br>" + country.upcase + "</div>" 
  end
end

