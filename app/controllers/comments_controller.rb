class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    if params[:user_id]
      @comment.commentable = User.find(params[:user_id])
    elsif params[:goal_id]
      @comment.commentable = Goal.find(params[:goal_id])
    end
    @comment.save!
    redirect_to :back
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
