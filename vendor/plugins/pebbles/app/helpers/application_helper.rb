
module ApplicationHelper
  include HeaderHelper
  
  def button_to_remote name, options = {}
    button_to_function name, remote_function(options)
  end

  def products_in_shopping_cart?
    true if current_cart.cart_items.size > 0 
  end
  
  # returns class style as 'current' if active page
  def current_style(id)
    case id
    when "home"
      'class=active' if current_page?(:controller => 'index', :action => 'home') ||
                        current_page?('/')
    when "about" 
      'class=active' if current_page?(:controller => 'index', 
                                :action => 'about')
    when "cart"
      'class=active' if current_page?(:controller => 'carts', :action => 'show')
    when "contact"
      'class=active' if current_page?(:action => 'contact_us')
    when "retail"
      'class=active' if current_page?(:controller => 'stores')
    end
  end
  
  def shipping_region(id)
    Region.find(id).name
  end
  
  def shipping_method(id)
    ShippingMethod.find(id).name
  end
  
  # Produces -> Thursday, May 25 2006 
  def nice_date(date)
    unless date.nil?
      h date.strftime("%A, %B %d %Y")
    end
  end
  
  # the page title for each individual page
   def title(page_title)
     content_for(:title) { page_title }
   end
  
   def default_title
     Optimization.first.title || "title"
   end
   
   # meta keywards for each page
   def meta_description(description)
     content_for(:meta_description) { description }
   end
   
   def default_description
     Optimization.first.description || "description"
   end

   # meta keywards for each page
   def meta_keywords(keywords)
     content_for(:meta_keywords) { keywords }
   end
  
   def default_keywords
     Optimization.first.keywords || "keywords"
   end
  
end
