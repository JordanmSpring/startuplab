class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :problems
  has_many :comments, -> { order(created_at: :desc) }
  has_many :founders
  has_many :users, through: :founders
end
