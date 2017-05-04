class EventPolicy < ApplicationPolicy
  class Scope < Scope

  def new?
    record.user == user
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


    def resolve
      scope
    end
  end
end
