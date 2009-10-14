  module Pebbles
    module ApplicationHelper
      include HeaderHelper
      
      def bread_crumb(category)
        category.parent.name + " : " unless category.parent.nil?
      end

      def production_environment? 
        if Rails.env.production?
          yield
        end
      end
      
      def inventory_managed?
        GeneralConfiguration.instance.inventory_management?
      end
      
      def categories
        Category.position_sorted
      end
      
      ## 
      # this method returns a style to hide the element if it is a new_record unless the object is the 
      # first new_record. One must reset the @hide_object to false if one wants to use this logic in
      # several places on a page.
      def hide_unless_first_new_object(object)
        display = @hide_object ? "style=display:none" : ""
        @hide_object = object.new_record?
        return display
      end
      
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
        "title"
        #Optimization.first.title || "title"
      end
      
      # meta keywards for each page
      def meta_description(description)
        content_for(:meta_description) { description }
      end
      
      def default_description
        "description"
        #Optimization.first.description || "description"
      end

      # meta keywards for each page
      def meta_keywords(keywords)
        content_for(:meta_keywords) { keywords }
      end
      
      def default_keywords
        "keywords"
        #Optimization.first.keywords || "keywords"
      end
      
    end
  end
