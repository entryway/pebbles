class Category < ActiveRecord::Base
  
  has_many :category_images, :dependent => :destroy
  has_one :category_icon, :dependent => :destroy
  
  has_and_belongs_to_many :products
  #has_and_belongs_to_many :faux_products
  named_scope :active, :conditions => {:active => true}
  named_scope :position_sorted, :order => 'position'
  
  acts_as_nested_set 
  
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
      self.move_to_root
    end
    self.move_to_left_of options[:right].to_i if options[:right] =~ /\d/
  end
   
  # return the products paged
  def paged_products(page, product_per_page)
     products.available.paginate :per_page => product_per_page, 
                                 :page => page, 
                                 :order => "name"
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

end
