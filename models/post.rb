class Post < ActiveRecord::Base
  has_many :comments
  has_many :tags
  belongs_to :user
end

# user_id INTEGER,						Point B	Belongs to a User
# tag_id INTEGER, 						Point D	Has many Tags
# comment_id INTEGER,					Point C	Has many Comments
