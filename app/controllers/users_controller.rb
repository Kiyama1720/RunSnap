class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: params[:id])
    @posts = Post.where(user_id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: params[:id])
    @posts = Post.where(user_id: params[:id])
    if @user.id != current_user.id
      render :show
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def hide
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to "/"
  end

  private

  def user_params
    params.require(:user).permit(:email, :user_id, :name, :image)
  end
end
