class Comment < ActiveRecord::Base

  scope :recent, -> { order('comments.created_at DESC') }

  belongs_to :idea
  belongs_to :user
end
