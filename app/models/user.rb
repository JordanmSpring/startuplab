class User < ActiveRecord::Base
  acts_as_voter

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  scope :admins, -> { where(role: ROLE_ADMIN) }
  scope :users,  -> { where(role: ROLE_USER) }
  scope :recent, -> { order('users.created_at DESC') }

  has_many :comments
  has_many :ideas # TODO: Should we only have ideas through founders??
  has_many :user_ideas
  has_many :shared_ideas, through: :user_ideas
  has_many :founders, dependent: :destroy

  ROLES = [
    ROLE_USER  = 'user',
    ROLE_ADMIN = 'admin',
  ]

  validates :role,
            presence:  true,
            inclusion: ROLES

  def pending?
    return false if self.invitation_created_at.blank?
    self.invitation_accepted_at.blank?
  end

  def is_admin?
    role == User::ROLE_ADMIN
  end

  def plan
    Plan.find_by_id(self[:plan])
  end

  def reached_idea_limit?
    ideas.count >= plan.max_num_ideas.to_i && !plan.max_num_ideas.nil? && !is_admin?
  end

  def can_export?
    plan.can_export? || is_admin?
  end

  def can_notify?
    plan.can_notify? || is_admin?
  end

  def self.from_omniauth(auth)
    User.find_by(email: auth.info.email) || where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email    = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name     = auth.info.name
    end
  end

end
