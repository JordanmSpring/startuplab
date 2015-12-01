class IdeaPolicy < ApplicationPolicy
  def show?
    @record.published? || (user.present? && super)
  end

  def update?
    @record.founder?(user)
  end

  def publish?
    update?
  end

  def unpublish?
    update?
  end

  def destroy?
    @record.owner?(user)
  end

  class Scope < Scope
    def resolve
      scope.with_founder(user)
    end
  end
end
