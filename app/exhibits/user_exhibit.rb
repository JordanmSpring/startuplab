class UserExhibit
  attr_reader :object

  def initialize(user)
    @object = user
  end

  def as_json(options = {})
    {
      id:          object.id,
      name:        object.name || 'Unknown',
      gravatarUrl: gravatar_url,
      pending:     object.pending?,
      plan:        plan
    }.as_json
  end

  def gravatar_url
    @gravatar_url ||= GravatarUrlGenerator.new(object.email).generate
  end

  def plan
    {
      id:                 object.plan.id,
      name:               object.plan.name,
      ideaLimit:          object.plan.max_num_ideas,
      ideaCount:          object.ideas.count,
      publishedIdeaCount: object.ideas.published.count,
      reachedIdeaLimit:   object.reached_idea_limit?,
      canExport:          object.can_export?,
      canPublishIdeas:    object.can_publish_ideas?,
      canSeeFinancials:   object.can_see_financials?,
    }
  end
end
