class CategoryIcon < ActiveRecord::Base

  belongs_to :category
  has_one :category_icon_hover, :dependent => :destroy

  mount_uploader :filename, CategoryIconUploader

  validates_presence_of :filename

end