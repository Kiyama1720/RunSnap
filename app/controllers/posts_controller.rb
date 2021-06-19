class PostsController < ApplicationController
  def new
    @post = Post.new
    p ENV["GOOGLE_MAP_API_KEY"]
    gon.google_map_api_key = ENV["GOOGLE_MAP_API_KEY"]
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post.id)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    gon.google_map_api_key = ENV["GOOGLE_MAP_API_KEY"]
  end

  def edit
    @post = Post.find(params[:id])
    gon.google_map_api_key = ENV["GOOGLE_MAP_API_KEY"]
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to "/"
  end

  private

  def post_params
    params.require(:post).permit(:title, :user_id, :body, :image, :address, :latitude, :longitude)
  end
end
