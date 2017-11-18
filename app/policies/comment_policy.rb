class CommentPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end
end
