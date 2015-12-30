class CommentPolicy < ApplicationPolicy
  def show?
    @record.approved? || @record.owner?(user)
  end

  def update?
    @record.owner?(user) || user.is_admin?
  end

  def create?
    true
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      # Users can see their own comments, even if they have not been approved.
      if user.present?
        scope.where('comments.status = ? OR comments.user_id = ?', Comment::STATUS_APPROVED, user.id)
      else
        scope.approved
      end
    end
  end
end
