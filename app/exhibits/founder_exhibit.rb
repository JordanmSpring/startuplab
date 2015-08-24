class FounderExhibit
  attr_reader :object

  def initialize(founder)
    @object = founder
  end

  def as_json(options = {})
    attributes.tap { |attrs|
      if object.user.present?
        attrs.merge!(user: UserExhibit.new(object.user))
      end
    }.as_json
  end

  def attributes
    {
      id: object.id,
      role: object.role,
      created_at: object.created_at
    }
  end
end
