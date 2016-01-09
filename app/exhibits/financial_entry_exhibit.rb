class FinancialEntryExhibit
  attr_reader :object

  def initialize(entry)
    @object = entry
  end

  def as_json(options = {})
    object.attributes.as_json
  end
end
