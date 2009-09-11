require "faster_csv" 

class StoreImportController < ApplicationController

  def import
    FasterCSV.foreach("lib/GreenLabelLegacy.csv") do |row|
      address = row[1].to_s.strip
      city = row[2].to_s.strip
      state = row[3].to_s.strip
      zip = row[4].to_s.strip
      storename = row[5].to_s.strip
      lat = row[6].to_f
      lng = row[7].to_f
      hours = row[8].to_s.strip
      url = row[9].to_s.strip
      phone = row[13].to_s.strip
      country = row[17].to_s.strip
      
      store = Store.new(:address => address,
                        :city =>city,
                        :state => state,
                        :zip => zip,
                        :storename => storename,
                        :url => url,
                        :phone => phone,
                        :country => country)
      store = Store.geocode_address(store)
      store.save!
           
    end
  end
  
end
