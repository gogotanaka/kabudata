class Board < ActiveRecord::Base
  attr_accessible :stock_id, :title
  has_many :comments
end
