class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :ideas # TODO: Should we only have ideas through founders??
  has_many :founders, dependent: :destroy

  def pending?
    return false if self.invitation_created_at.blank?
    self.invitation_accepted_at.blank?
  end
end
