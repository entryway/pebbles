module Pebbles::OrdersHelper
  
  def cart_is_taxed?(tax_total)
    tax_total == 0 ? "display:none" : ""
  end
    
  def previous_address_choice?
    if controller.action_name == 'create'
      !params[:address_choice].nil?
    else
      true
    end
  end
  
  
  def country(address, type)
    region_name = shipping_region(active_shipping_region_id)
    if region_name == "United States"
      "United States" + hidden_field_tag(type + "[country]", "United States")
    elsif region_name == "Canada"
      "Canada" + hidden_field_tag(type + "[country]", "Canada")
    else
      # remove Canada, USA from list of international countries
      countries = ActionView::Helpers::FormOptionsHelper::COUNTRIES - 
                  ["United States", "Canada", "United States Minor Outlying Islands",
                   "Virgin Islands, U.S.", "South Georgia and the South Sandwich Islands",
                   "Macedonia, The Former Yugoslav Republic Of", "Korea, Democratic People's Republic of",
                   "Congo, the Democratic Republic of the", "Lao People's Democratic Republic",
                   "Saint Vincent and the Grenadines", "Micronesia, Federated States of",
                   "Palestinian Territory, Occupied", "British Indian Ocean Territory",
                   "Falkland Islands (Malvinas)", "Tanzania, United Republic of", 
                   "Heard and McDonald Islands", "Holy See (Vatican City State)",
                   "Northern Mariana Islands", "French Southern Territories",
                   "Turks and Caicos Islands", "Taiwan, Province of China" ]
   	  address.select :country, countries, { :prompt => 'Select Country' }
    end
  end
  
  def state(address, type)
    region_name = shipping_region(active_shipping_region_id)
    if region_name == "United States"
   	  address.select :state, 
   	    [['Select a State', ''],
      	['Alabama', 'AL'], 
      	['Alaska', 'AK'],
      	['Arizona', 'AZ'],
      	['Arkansas', 'AR'], 
      	['California', 'CA'], 
      	['Colorado', 'CO'], 
      	['Connecticut', 'CT'], 
      	['Delaware', 'DE'], 
      	['District Of Columbia', 'DC'], 
      	['Florida', 'FL'],
      	['Georgia', 'GA'],
      	['Hawaii', 'HI'], 
      	['Idaho', 'ID'], 
      	['Illinois', 'IL'], 
      	['Indiana', 'IN'], 
      	['Iowa', 'IA'], 
      	['Kansas', 'KS'], 
      	['Kentucky', 'KY'], 
      	['Louisiana', 'LA'], 
      	['Maine', 'ME'], 
      	['Maryland', 'MD'], 
      	['Massachusetts', 'MA'], 
      	['Michigan', 'MI'], 
      	['Minnesota', 'MN'],
      	['Mississippi', 'MS'], 
      	['Missouri', 'MO'], 
      	['Montana', 'MT'], 
      	['Nebraska', 'NE'], 
      	['Nevada', 'NV'], 
      	['New Hampshire', 'NH'], 
      	['New Jersey', 'NJ'], 
      	['New Mexico', 'NM'], 
      	['New York', 'NY'], 
      	['North Carolina', 'NC'], 
      	['North Dakota', 'ND'], 
      	['Ohio', 'OH'], 
      	['Oklahoma', 'OK'], 
      	['Oregon', 'OR'], 
      	['Pennsylvania', 'PA'], 
      	['Rhode Island', 'RI'], 
      	['South Carolina', 'SC'], 
      	['South Dakota', 'SD'], 
      	['Tennessee', 'TN'], 
      	['Texas', 'TX'], 
      	['Utah', 'UT'], 
      	['Vermont', 'VT'], 
      	['Virginia', 'VA'], 
      	['Washington', 'WA'], 
      	['West Virginia', 'WV'], 
      	['Wisconsin', 'WI'], 
      	['Wyoming', 'WY']]
    else
      address.text_field :state, :size => 20 
    end
  end
end


