class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :problems
  has_many :comments, -> { order(created_at: :desc) }
  has_many :founders, -> { order(:created_at) }
  has_many :users, through: :founders
  has_and_belongs_to_many :channels
  has_and_belongs_to_many :crowdfunding_options

  scope :published, -> { where(published: true) }
  scope :draft,     -> { where.not(published: true) }

  def self.with_founder(user)
    joins(:users).where(users: { id: user.id })
  end

  def publish!
    update!(published: true)
  end

  def owner?(user)
    self.user == user
  end

  def founder?(user)
    self.users.include?(user)
  end

  def channel_names=(array)
    self.channels = array.map do |name|
      Channel.find_by(name: name)
    end
  end

  def channel_names
    self.channels.map(&:name)
  end

  def funding_option_names=(array)
    self.crowdfunding_options = array.map do |name|
      CrowdfundingOption.find_by(name: name)
    end
  end

  def funding_option_names
    self.crowdfunding_options.map(&:name)
  end
end
