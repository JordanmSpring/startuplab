class IdeaPolicy < ApplicationPolicy
  def show?
    @record.published? || (user.present? && super) || user.admin?
  end

  def create?
    !user.reached_idea_limit?
  end

  def update?
    @record.founder?(user) || user.admin?
  end

  def share?
    update?
  end

  def publish?
    update? && user.can_publish_ideas?
  end

  def unpublish?
    update?
  end

  def export?
    show? && user.can_export?
  end

  def destroy?
    @record.owner?(user) || user.admin?
  end

  class Scope < Scope
    def resolve
      scope.with_founder(user)
    end
  end
end
