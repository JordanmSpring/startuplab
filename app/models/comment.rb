class Comment < ActiveRecord::Base

  scope :recent,   -> { order('comments.created_at DESC') }
  scope :approved, -> { where(status: STATUS_APPROVED) }
  scope :pending,  -> { where(status: STATUS_PENDING) }
  scope :rejected, -> { where(status: [STATUS_REJECTED_BY_AKISMET, STATUS_REJECTED_BY_ADMIN]) }

  belongs_to :idea
  belongs_to :user

  STATUSES = [
    STATUS_PENDING             = 'pending',
    STATUS_REJECTED_BY_AKISMET = 'rejected by akismet',
    STATUS_REJECTED_BY_ADMIN   = 'rejected by admin',
    STATUS_APPROVED            = 'approved',
  ]

  validates :status,
            presence:  true,
            inclusion: STATUSES

  def owner?(_user)
    user == _user
  end

  def approved?
    status == STATUS_APPROVED
  end

  def approve!
    update_attribute(:status, STATUS_APPROVED)
  end

  def rejected?
    [STATUS_REJECTED_BY_AKISMET, STATUS_REJECTED_BY_ADMIN].include?(status)
  end

  def reject!
    update_attribute(:status, STATUS_REJECTED_BY_ADMIN)
  end
end
