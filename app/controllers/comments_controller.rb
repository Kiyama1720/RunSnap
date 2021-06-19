class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.comment_number = 1
    comment.save
    redirect_to post_path(@post.id)
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:comment).permit(:comment)
  end
end
