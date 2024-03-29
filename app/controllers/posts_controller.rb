class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    gon.google_map_api_key = ENV["GOOGLE_MAP_API_KEY"]
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    gon.google_map_api_key = ENV["GOOGLE_MAP_API_KEY"]
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    gon.google_map_api_key = ENV["GOOGLE_MAP_API_KEY"]
  end

  def edit
    @post = Post.find(params[:id])
    @comment = Comment.new
    gon.google_map_api_key = ENV["GOOGLE_MAP_API_KEY"]
    if @post.user_id != current_user.id
      render :show
    end
  end

  def update
    @post = Post.find(params[:id])
    gon.google_map_api_key = ENV["GOOGLE_MAP_API_KEY"]
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to "/"
  end

  def search
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  private

  def post_params
    params.require(:post).permit(:title, :user_id, :body, :image, :address, :latitude, :longitude)
  end
end
