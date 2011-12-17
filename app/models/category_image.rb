class CategoryImage < ActiveRecord::Base

  belongs_to :category

  mount_uploader :filename, ImageUploader

  validates_presence_of :filename

end