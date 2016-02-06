class UserIdeaExhibit
  attr_reader :object

  def initialize(user_idea)
    @object = user_idea
  end

  def as_json(options = {})
    {
      id:     object.id,
      status: status,
      user:   UserExhibit.new(object.shared_user),
      idea:   IdeaExhibit.new(object.shared_idea, User.new),
    }.as_json
  end

  private

    def status
      if object.shared_user.sign_in_count == 0
        'pending'
      else
        'accepted'
      end
    end
end
