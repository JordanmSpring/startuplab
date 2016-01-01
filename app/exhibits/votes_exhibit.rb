class VotesExhibit
  attr_reader :collection

  def initialize(votes)
    @collection = votes
  end

  def as_json(options = {})
    @collection.map { |vote| VoteExhibit.new(vote) }.as_json
  end
end
