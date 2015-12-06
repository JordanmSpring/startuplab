class UserIdea < ActiveRecord::Base

  # Access levels.
  ACCESS_LEVELS = [
    ACCESS_READ  = 'read',
    ACCESS_WRITE = 'write',
  ]

  # Ideas already have a collection of 'users' (a collection of founders), so we
  # name the collection of users who an idea has been shared to 'shared_users'.
  belongs_to :shared_user, class_name: User.name, foreign_key: :user_id
  belongs_to :shared_idea, class_name: Idea.name, foreign_key: :idea_id

  validates :access_level,
             presence:  true,
             inclusion: { in: ACCESS_LEVELS }

  def as_json
    {
      id:   id,
      user: UserExhibit.new(shared_user),
      idea: IdeaExhibit.new(shared_idea, User.new),
    }
  end

end
