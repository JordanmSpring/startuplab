class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :problems
  has_many :comments, -> { order(created_at: :desc) }
  has_many :founder_positions
  has_many :founders, through: :founder_positions
end
