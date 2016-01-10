class Comment < ActiveRecord::Base
  include Rakismet::Model

  # The number of minutes to wait before sending a notification about a comment.
  # This avoids spamming people with notifications, since we group them in 30
  # minute chunks.
  NOTIFICATION_DELAY_MINUTES = 30

  scope :recent,             -> { order('comments.created_at DESC') }
  scope :approved,           -> { where(status: STATUS_APPROVED) }
  scope :pending,            -> { where(status: STATUS_PENDING) }
  scope :rejected,           -> { where(status: STATUS_REJECTED) }
  scope :flagged_by_akismet, -> { where(status: STATUS_FLAGGED_BY_AKISMET) }
  scope :not_notified,       -> { where(notified: false) }
  scope :not_recent,         -> { where('comments.created_at < ?', (ENV['NOTIFICATION_DELAY_MINUTES'] || NOTIFICATION_DELAY_MINUTES).to_i.minutes.ago) }

  belongs_to :idea
  belongs_to :user

  STATUSES = [
    STATUS_PENDING             = 'pending',
    STATUS_FLAGGED_BY_AKISMET  = 'flagged by akismet',
    STATUS_REJECTED            = 'rejected',
    STATUS_APPROVED            = 'approved',
  ]

  validates :body,
            presence:  true

  validates :status,
            presence:  true,
            inclusion: STATUSES

  after_create :spam_check

  # Maps fields for use with the Akismet spam-checking API.
  rakismet_attrs author:       proc { user.name },
                 author_email: proc { user.email },
                 user_ip:      proc { user.current_sign_in_ip.to_s },
                 content:      :body

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
    status == STATUS_REJECTED
  end

  def reject!
    update_attribute(:status, STATUS_REJECTED)
  end

  private

    # Uses the Akismet API to decide whether or not this is spam.
    def spam_check
      CommentSpamCheckWorker.perform_in(5.seconds, id)
    end
end
