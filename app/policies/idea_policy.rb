class IdeaPolicy < ApplicationPolicy
  def show?
    @record.published? || (user.present? && super) || user.is_admin?
  end

  def create?
    !user.reached_idea_limit?
  end

  def update?
    @record.founder?(user) || user.is_admin?
  end

  def share?
    update?
  end

  def publish?
    update?
  end

  def unpublish?
    update?
  end

  def destroy?
    @record.owner?(user) || user.is_admin?
  end

  class Scope < Scope
    def resolve
      scope.with_founder(user)
    end
  end
end
