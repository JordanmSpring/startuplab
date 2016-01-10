class IdeaExhibit
  attr_reader :object

  def initialize(idea, current_user)
    @object = idea
    @user   = current_user
  end

  def as_json(options = {})
    object.attributes.merge(
      comments:         CommentsExhibit.new(CommentPolicy::Scope.new(@user, @object.comments).resolve),
      votes:            VotesExhibit.new(@object.votes),
      founders:         FoundersExhibit.new(@object.founders, hide_pending: !can_edit?),
      fundingOptions:   @object.funding_option_names,
      financialEntries: FinancialEntriesExhibit.new(FinancialEntryPolicy::Scope.new(@user, @object.financial_entries).resolve),
      channels:         @object.channel_names,
      user:             UserExhibit.new(@object.user),
      canEdit:          can_edit?,
      owner:            owner?,
      voted:            (@user.present? && @user.voted_for?(@object))
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
