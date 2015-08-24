class Founder < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user
end
