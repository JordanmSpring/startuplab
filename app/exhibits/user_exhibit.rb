class UserExhibit
  attr_reader :object

  def initialize(user)
    @object = user
  end

  def as_json(options = {})
    {
      id: object.id,
      name: object.name || object.email,
      gravatarUrl: gravatar_url,
      pending: object.pending?
    }.as_json
  end

  def gravatar_url
    @gravatar_url ||= GravatarUrlGenerator.new(object.email).generate
  end
end
