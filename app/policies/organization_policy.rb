class OrganizationPolicy < ApplicationPolicy

  def index?
    return false
  end

  def new?
    record.user == user
  end

  def organization_contact?
    return false
  end

  def organization_send?
    return false
  end

  def like
    return false
  end

  def create?
   return true
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
