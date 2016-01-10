class FinancialEntryPolicy < ApplicationPolicy
  def show?
    @record.idea.founder?(user) && user.can_see_financials?
  end

  def create?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      if (user.persisted?)
        scope.joins(:idea).where('ideas.user_id = ?', user.id)
      else
        scope.none
      end
    end
  end
end
