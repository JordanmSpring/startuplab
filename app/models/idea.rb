class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :problems
  has_many :comments, -> { order(created_at: :desc) }
  has_many :founders, -> { order(:created_at) }
  has_many :users, through: :founders
  has_and_belongs_to_many :channels

  def channel_names=(array)
    self.channels = array.map do |name|
      Channel.find_by(name: name)
    end
  end

  def channel_names
    self.channels.map(&:name)
  end
end
