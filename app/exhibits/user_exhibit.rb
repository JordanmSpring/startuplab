class UserExhibit
  attr_reader :object

  def initialize(user)
    @object = user
  end

  def as_json(options = {})
    {
      id: object.id,
      name: object.name || object.email,
      email: object.email,
      gravatarUrl: gravatar_url,
      pending: pending?
    }.as_json
  end

  def gravatar_url
    @gravatar_url ||= GravatarUrlGenerator.new(object.email).generate
  end

  def pending?
    return false if object.invitation_created_at.blank?
    object.invitation_accepted_at.blank?
  end
end
