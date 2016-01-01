class Vote < ActiveRecord::Base
  scope :for_voter,    -> (voter)    { where(['voter_id = ? AND voter_type = ?', voter.id, voter.class.base_class.name]) }
  scope :for_voteable, -> (voteable) { where(['voteable_id = ? AND voteable_type = ?', voteable.id, voteable.class.base_class.name]) }
  scope :recent,       -> (created)  { where(['created_at > ?', (created || 2.weeks.ago)]) }
  scope :descending,   -> (*args)    { order('created_at DESC') }

  belongs_to :voteable, polymorphic: true
  belongs_to :voter,    polymorphic: true

  validates :voteable_id, presence:   true,
                          uniqueness: { scope: [:voteable_type, :voter_type, :voter_id], case_sensitive: false }

end
