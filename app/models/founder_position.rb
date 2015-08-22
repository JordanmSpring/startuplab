class FounderPosition < ActiveRecord::Base
  belongs_to :idea
  belongs_to :founder, class_name: 'User'
end
