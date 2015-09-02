class IdeaExhibit
  attr_reader :object

  def initialize(idea, current_user)
    @object = idea
    @user   = current_user
  end

  def as_json(options = {})
    object.attributes.merge(
      comments: CommentsExhibit.new(@object.comments),
      founders: FoundersExhibit.new(@object.founders),
      channels: @object.channel_names,
      user: UserExhibit.new(@object.user),
      mine: @object.users.include?(@user)
    ).as_json
  end
end
