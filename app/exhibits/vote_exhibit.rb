class VoteExhibit
  attr_reader :object

  def initialize(vote)
    @object = vote
  end

  def as_json(options = {})
    {
      id:   object.id,
      user: UserExhibit.new(object.voter),
    }.as_json
  end
end
