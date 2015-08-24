class FoundersExhibit
  attr_reader :collection

  def initialize(founders)
    @collection = founders
  end

  def as_json(options = {})
    @collection.map { |founder| FounderExhibit.new(founder) }.as_json
  end
end
