class Plan::Founder < Plan
  def self.id
    'founder'
  end

  def self.name
    'Founder'
  end

  def self.amount
    1000
  end

  def self.features
    []
  end

  # Used to indicate whether this plan is 'coming soon'.
  def self.is_live?
    false
  end
end
