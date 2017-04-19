class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    organization = Organization.find(params[:id])
    comment = organization.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment has been created."
      redirect_to organization
    else
      flash[:alert] = "Comment has not been created."
    end
  end

  def show
    @organization = Organization.find(params[:id])
    @comments = @organization.comments
  end

  private
    def comment_params
      params.permit(:comment)
    end
end
