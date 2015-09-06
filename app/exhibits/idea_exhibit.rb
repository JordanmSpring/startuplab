class IdeaExhibit
  attr_reader :object

  def initialize(idea, current_user)
    @object = idea
    @user   = current_user
  end

  def as_json(options = {})
    object.attributes.merge(
      comments: CommentsExhibit.new(@object.comments),
      founders: FoundersExhibit.new(@object.founders, hide_pending: !can_edit?),
      fundingOptions: @object.funding_option_names,
      channels: @object.channel_names,
      user: UserExhibit.new(@object.user),
      idea: @object.published?,
      canEdit: can_edit?,
      owner: owner?
    ).as_json
  end

  private
    def can_edit?
      @object.founder?(@user) || owner?
    end

    def owner?
      @object.owner?(@user)
    end
end
