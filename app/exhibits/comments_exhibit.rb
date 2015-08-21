class CommentsExhibit
  attr_reader :collection

  def initialize(comments)
    @collection = comments
  end

  def as_json(options = {})
    @collection.map { |comment| CommentExhibit.new(comment) }.as_json
  end
end
