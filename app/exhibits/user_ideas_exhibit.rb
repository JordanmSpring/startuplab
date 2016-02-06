class UserIdeasExhibit
  attr_reader :collection

  def initialize(user_ideas)
    @collection = user_ideas
  end

  def as_json(options = {})
    @collection.map { |user_idea| UserIdeaExhibit.new(user_idea) }.as_json
  end
end
