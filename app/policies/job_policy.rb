class JobPolicy < ApplicationPolicy
  def edit?
    user.organizations.include?(record.organization)
  end

  def update?
    user.organizations.include?(record.organization)
  end

  def destroy?
    user.organizations.include?(record.organization)
  end
end
