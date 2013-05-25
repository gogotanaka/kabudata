class Blog < ActiveRecord::Base
  attr_accessible :describe, :title, :url
  has_many :ins
end
