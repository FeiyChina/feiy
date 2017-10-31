class CommentsController < ApplicationController
  before_action :authenticate_user!
  include CommentableController

  def create
    comment = @commentable.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment has been created."
      redirect_to @commentable
    else
      flash[:alert] = "Comment has not been created."
    end
  end

  def destroy
    if current_user.admin? && @comment.destroy
      flash[:notice] = "Comment has been deleted."
      redirect_to @commentable
    else
      flash[:alert] = "Comment has not been deleted."
    end
  end

  private

  def comment_params
    params.permit(:comment, :commentable_type, :commentable_id, :id)
  end
end
