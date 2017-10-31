module CommentableController
  extend ActiveSupport::Concern

  included do
    before_action :find_commentable, only: [:create, :destroy]
    before_action :find_comment, only: [:destroy]
    before_action :authorize_comment, only: [:destroy]
  end

  def find_comment
    @comment = Comment.find(comment_params[:id])
  end

  def find_commentable
    commentable_class = comment_params[:commentable_type].constantize
    @commentable = commentable_class.find(comment_params[:commentable_id])
  end

  def authorize_comment
    authorize(@comment)
  end
end
