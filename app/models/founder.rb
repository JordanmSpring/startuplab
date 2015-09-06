class Founder < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user

  def pending?
    user.blank? || user.pending?
  end
end
