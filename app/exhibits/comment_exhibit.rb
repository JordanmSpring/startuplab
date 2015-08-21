class CommentExhibit
  attr_reader :object

  def initialize(comment)
    @object = comment
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
      body: object.body,
      created_at: object.created_at
    }
  end
end
