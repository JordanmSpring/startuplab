class FinancialEntriesExhibit
  attr_reader :collection

  def initialize(entries)
    @collection = entries
  end

  def as_json(options = {})
    @collection.inject({ }) do |hash, entry|
      hash[entry.group] ||= []
      hash[entry.group] << FinancialEntryExhibit.new(entry)
      hash
    end
  end
end
