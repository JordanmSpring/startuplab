class User < ActiveRecord::Base
  acts_as_voter

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :linkedin, :twitter]

  # Used to send custom 'share' user invitations.
  attr_writer :invitation_instructions

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

  def admin?
    role == User::ROLE_ADMIN
  end

  def plan
    Plan.find_by_id(plan_id)
  end

  def reached_idea_limit?
    ideas.count >= plan.max_num_ideas.to_i && !plan.max_num_ideas.nil? && !admin?
  end

  def can_export?
    plan.can_export? || admin?
  end

  def can_notify?
    plan.can_notify? || admin?
  end

  def can_publish_ideas?
    plan.can_publish_ideas? || admin?
  end

  def can_see_financials?
    plan.can_see_financials? || admin?
  end

  # Tells devise not to perform email validation.
  def email_required?
    provider != 'twitter'
  end

  def self.from_omniauth(auth)
    existing = User.find_by(email: auth.info.email)
    if existing
        existing.tap do |user|
          user.update_attributes(provider: auth.provider, uid: auth.uid)
        end
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        # Twitter doesn't provide email addresses.
        user.email    = (auth.provider == 'twitter' ? '' : auth.info.email)
        user.password = Devise.friendly_token[0,20]
        user.name     = auth.info.name
      end
    end
  end

  def deliver_invitation
   if @invitation_instructions.present?
      # We don't want to deliver the invitation email immediately, because we
      # haven't linked together all of the relevant objects yet. At this stage
      # we still haven't saved the UserIdea instance, because we need to invite
      # the user as part of creation, so it isn't linked to the UserIdea yet.
     ::Devise.mailer.send(@invitation_instructions, self, token: @raw_invitation_token).deliver_later(wait_until: 1.minute.from_now)
   else
     super
   end
  end

  def self.invite_share!(attributes={}, invited_by=nil)
   self.invite!(attributes, invited_by) do |invitable|
     invitable.invitation_instructions = :share_invitation_instructions
   end
  end

end
