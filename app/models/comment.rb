class Comment < ActiveRecord::Base
  attr_accessible :board_id, :contents, :sender
  belongs_to :board,  touch: true
end
