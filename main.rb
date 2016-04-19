require 'sinatra'
require 'sinatra/reloader'
require './db_config'
require './models/post'
require './models/user'
require './models/comment'
require './models/tag'
# filter to close connection after
after do
  ActiveRecord::Base.connection.close
end

# ========================
# MAIN HOME PAGE - URL/
get '/' do
  erb :index
end
# ========================
# ========================
# ADD NEW POST (Create)
# renders form - method post - redirected
# ========================
# ========================
get '/posts/new' do
  @user = User.all
  erb :new
end

post '/posts' do
  @post = Post.new
  @post.title = params[:title]
  # @post.name = params[:name]
  @post.body = params[:body]
  @post.save
  redirect to '/posts'
end

# ========================
# ========================
# EDIT EXISTING POST (Update)
# renders form - passing in pre-existing values
# ========================
get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  erb :edit
end

patch '/posts/:id' do
  @post = Post.find(params[:id])
  @post.title = params[:title]
  @post.body = params[:body]
  @post.save
  redirect to '/posts'
end

# ========================
# ========================
# DISPLAYING POSTS (Read)
# all or individual based on url
# ========================
get '/posts' do
  @posts = Post.all
  @users = User.all
  erb :show
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  @user = User.find(@post.user_id)
  erb :showsingle
end

# ========================
# ========================
# DELETING INDIVIDUAL POST (Destroy)
# ========================
get '/delete/:id' do
  @post = Post.find(params[:id])
  erb :delete
end

def destroy
    @status_update = StatusUpdate.find(params[:id])
    if @status_update.present?
      @status_update.destroy
    end
    redirect_to root_url
end

delete '/delete/:id' do
  @post = Post.find(params[:id])
  if @post.present?
    @post.destroy
  end
  redirect to '/posts'
end
# ========================


# ========================
# ========================
# USER FUNCTION ==========
# ========================
# ========================
# User Login
get '/user/login' do
  erb :login
end

post '/user' do
  # if user by email
  user = User.find_by(email: params[:email])
  # if user email and password exist - log in, else do nothing
  if user.authenticate(params[:password])
    redirect to '/posts'
  else
    redirect to '/'
  end
end

#User Signup
get '/user/signup' do
  erb :signup
end

post '/user/new' do
  user = User.new
  user.name = params[:name]
  user.email = params[:email]
  user.password = params[:password]
  user.save
  redirect to '/posts'
end

#User Edit
# get '/user/profile' do
#   @user = User.all
#   erb :profileEdit
# end


#User Log out
