
class Category < ActiveRecord::Base
  has_many :category_images
  has_and_belongs_to_many :products
  #has_and_belongs_to_many :faux_products
  named_scope :active, :conditions => {:active => true}
  
  acts_as_nested_set 
  
  attr_accessor :style
  
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
  
  def category_image
    return category_images[0].public_filename unless category_images.empty?
    ''
  end
  
  def self.position_sorted
    return [] if root.nil?
    root.children.sort_by { |a| a.position }
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
