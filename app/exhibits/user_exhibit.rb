class UserExhibit
  attr_reader :object

  def initialize(user)
    @object = user
  end

  def as_json(options = {})
    {
      id: object.id,
      name: object.name
    }.as_json
  end
end
