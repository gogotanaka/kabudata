class Comment < ActiveRecord::Base
  attr_accessible :board_id, :contents, :sender
end
