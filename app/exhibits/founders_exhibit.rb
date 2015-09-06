class FoundersExhibit
  attr_reader :collection

  def initialize(founders, hide_pending: false)
    @collection = founders
    @hide_pending = hide_pending
  end

  def as_json(options = {})
    filtered_collection.map { |founder| FounderExhibit.new(founder) }.as_json
  end

  def filtered_collection
    if @hide_pending
      @collection.select { |founder| !founder.pending? }
    else
      @collection
    end
  end
end
