require 'pry'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDERR)

require './db_config'
require './models/post'
require './models/comment'
require './models/user'
require './models/tag'
# 
# comments = Comment.where(post_id: 17)
# comments.each do |comment|
#   User.find(comment.user_id).name
#   puts comment.user_id
#   puts comment.body
# end

binding.pry
