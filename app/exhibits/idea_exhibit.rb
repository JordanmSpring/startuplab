class IdeaExhibit
  attr_reader :object

  def initialize(idea)
    @object = idea
  end

  def as_json(options = {})
    object.attributes.merge(
      comments: CommentsExhibit.new(@object.comments),
      user: UserExhibit.new(@object.user)
    ).as_json
  end
end
