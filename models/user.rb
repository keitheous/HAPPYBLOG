class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :comments
end

# post_id INTEGER	,							Point A	Has many Posts
# comment_id INTEGER,						Point C	Has many Comments
