require 'sinatra'
require 'sinatra/reloader'
require './db_config'
require './models/post'
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
# ========================
# ========================
# ========================
# ========================
# ========================
# ========================
get '/posts/new' do
  erb :new
end

post '/posts' do
  @post = Post.new
  @post.title = params[:title]
  @post.name = params[:name]
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
  erb :show
end

get '/posts/:id' do
  @post = Post.find(params[:id])
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
