class Blog < ActiveRecord::Base
  attr_accessible :describe, :title, :url, :image, :rss
  mount_uploader :image, ImageUploader
  has_many :ins

  def entries
  	feed = Feedzirra::Feed.fetch_and_parse(self.rss)
  	if feed == 0
  		[]
  	else
  		feed.entries[0..2]
  	end
  end
end
