class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
end

# post_id INTEGER,						Point A	Belongs to a Post
# user_id INTEGER,						Point B	Belongs to a User
