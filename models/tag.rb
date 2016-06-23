class Tag < ActiveRecord::Base
  belongs_to :post
end

# post_id INTEGER,								Point A	Belongs to a Post
