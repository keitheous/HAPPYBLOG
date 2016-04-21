require 'sinatra'
require 'sinatra/reloader'
require './db_config'
require './models/post'
require './models/user'
require './models/comment'
require './models/tag'
enable :sessions
# filter to close connection after
helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

end

after do
  ActiveRecord::Base.connection.close
end

# ========================
# MAIN HOME PAGE - URL/
get '/' do
  erb :index
end

get '/about' do
  erb :about
end
# ========================
# ========================
# ADD NEW POST (Create)
# renders form - method post - redirected
# ========================p
# ========================
get '/posts/new' do
  if !(logged_in?)
    redirect to '/user/login'
  else
    erb :new
  end
end

post '/posts' do
  if !(logged_in?)
    redirect to '/user/login'
  else
    @post = Post.new
    if (!params[:title].present?)
      @post.title = "Happily Untitled"
    else
      @post.title = params[:title]
    end
    @post.user_id = current_user.id
    @post.body = params[:body]
    @post.save
    redirect to '/posts'
  end
end

# ========================
# ========================
# EDIT EXISTING POST (Update)
# renders form - passing in pre-existing values
# ========================
get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  if !(logged_in?)
    redirect to '/user/login'
  elsif @post.user_id != current_user.id
    redirect to '/posts'
  else
  erb :edit
  end
end

patch '/posts/:id' do
  @post = Post.find(params[:id])
  if !(logged_in?)
    redirect to '/user/login'
  elsif @post.user_id != current_user.id
    redirect to '/posts'
  else
    @post.title = params[:title]
    @post.body = params[:body]
    @post.save
    redirect to '/posts'
  end
end

# patch '/posts/:id' do
#   @post = Post.find(params[:id])
#   redirect to '/' if @post.user_id != current_user.id
#
#   @post.title = params[:title]
#   @post.body = params[:body]
#   @post.save
#   redirect to '/posts'
# end

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
  # this part is for posts
  @post = Post.find(params[:id])
  @poster = User.find(@post.user_id)
  @current = current_user
  # this part is for comments
  # @comments = Comment.where(post_id: 17)
  @comments = Comment.where(post_id: @post.id)
  @commenter = User.find(@comments.user_id)






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
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/posts'
  else
    erb :login
  end
end

#User Signup
get '/user/signup' do
  erb :signup
end
post '/user/new' do
  @user = User.new
  @user.name = params[:name]
  @user.email = params[:email]
  @user.password = params[:password]
  @user.save
  session[:user_id] = @user.id
  redirect to '/posts'
end

# User Edit
get '/user/profile' do
  if (logged_in?)
    @user = User.find_by(name: current_user.name)
    erb :profiledit
  else
    redirect '/posts'
  end
end
patch '/user' do
  @user = User.find_by(name: current_user.name)
  if (logged_in?)
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save
    redirect '/user/profile'
  else
    redirect '/user/signup'
  end
end
#User Log out
get '/user/logout' do
  session[:user_id] = nil
  redirect to '/'
end
#DELETE USER!!!!
get "/user/delete" do
  @user = User.find_by(name: current_user.name)
  @user.destroy
  redirect to "/posts"

end
