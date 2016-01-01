class Vote < ActiveRecord::Base
  # The number of minutes to wait before sending a notification about a vote.
  # This avoids spamming people with notifications, since we group them in 30
  # minute chunks.
  NOTIFICATION_DELAY_MINUTES = 30

  scope :for_voter,    -> (voter)    { where(['voter_id = ? AND voter_type = ?', voter.id, voter.class.base_class.name]) }
  scope :for_voteable, -> (voteable) { where(['voteable_id = ? AND voteable_type = ?', voteable.id, voteable.class.base_class.name]) }
  scope :recent,       -> (created)  { where(['created_at > ?', (created || 2.weeks.ago)]) }
  scope :descending,   -> (*args)    { order('created_at DESC') }
  scope :not_notified, -> { where(notified: false) }
  scope :not_recent,   -> { where('votes.created_at < ?', (ENV['NOTIFICATION_DELAY_MINUTES'] || NOTIFICATION_DELAY_MINUTES).to_i.minutes.ago) }

  belongs_to :voteable, polymorphic: true
  belongs_to :voter,    polymorphic: true

  validates :voteable_id, presence:   true,
                          uniqueness: { scope: [:voteable_type, :voter_type, :voter_id], case_sensitive: false }

end
