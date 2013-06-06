class Blog < ActiveRecord::Base
  attr_accessible :describe, :title, :url, :image
  mount_uploader :image, ImageUploader
  has_many :ins
end
