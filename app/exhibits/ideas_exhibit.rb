class IdeasExhibit
  attr_reader :collection

  def initialize(ideas, current_user)
    @collection = ideas
    @user       = current_user
  end

  def as_json(options = {})
    { ideas: @collection.map { |idea| IdeaExhibit.new(idea, @user) }.as_json }
  end
end
