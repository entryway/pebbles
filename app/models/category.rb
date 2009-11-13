class Category < ActiveRecord::Base
  
  has_many :category_images, :dependent => :destroy
  has_one :category_icon, :dependent => :destroy
  
  has_and_belongs_to_many :products
  #has_and_belongs_to_many :faux_products
  named_scope :active, :conditions => {:active => true}
  named_scope :position_sorted, :order => 'position'
  
  acts_as_nested_set 

  has_friendly_id :name, :use_slug => true
  
  attr_accessor :style
  
  ##
  # Reorders a category to nest under a parent category and above a sibling category
  #
  # @param[Hash] options an options of relation ids for ordering
  # @option options [String] :parent id of the parent category
  # #option options [String] :right id of the sibling category to the right
  def reorder(options = {})
    if options[:parent] =~ /\d/
      self.move_to_child_of options[:parent] 
    else
      self.move_to_child_of Category.root
    end
    self.move_to_left_of options[:right].to_i if options[:right] =~ /\d/
  end
   
  # return the products paged
  def paged_products(page, product_per_page)
     products.available.paginate :per_page => product_per_page, 
                                 :page => page, 
                                 :order => "name"
  end

  ##
  # A random set of products from all the children.
  
 
  def descended_paged_products(page, product_per_page)

    products = Array.new
    descendants.active.each do |category|
      products += category.products.available
    end
    products.uniq.paginate(:page => page, :per_page => product_per_page)
  end
  
  #
  def level
    self.ancestors.size
  end
  
  def self.position_sorted
    return [] if root.nil?
    root.children.position_sorted.active
  end
  
  def alpha_sorted
    children.sort_by { |a| a.name }
  end
  
  def self.alpha_sorted
    root.children.sort_by { |a| a.name }
  end
  
  def active_children
    Category.active.find(:all, :conditions => {:parent_id => self.id})
  end

  def self.order(ids)
    update_all(['position = FIND_IN_SET(id, ?)', ids.join(',')], { :id => ids })
  end

  ##
  # Return a category tree ordered by position. A tree is all the children and nested 
  # children not incluiding the current category. 
  #
  # If a specific category name is passed, it will be the root and not retured, all
  # its children and nested children will be returned. 
  #
  # TODO: Adapt to return a tree positioned, alphabetical, or natural ordered by
  # passing a paramenter hash.
  #
  # @param[String, Category] category_name The name of the category or the category to be the root of the tree.
  # @return[Category[]] The array of children and nested children categories. 
  def self.subtree(category=Category.root)
    if category.is_a?(String)
      category = Category.find_by_name(category)
    end

    return Array.new unless category 
 
    category.children.active
  end

  ##
  # Featured products for a specific category.
  #
  # @param[String] cateogry_name The name of the category to grab featured products from.
  # @return[Product[]] An array of products that are featured.
  def self.featured(category_name)
    category = Category.find_by_name(category_name)
    category.products.featured
  end

  def category_image
    category_images.first.filename.url
  end

end
