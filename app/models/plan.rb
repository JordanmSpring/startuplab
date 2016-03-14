class Plan
  PLANS = [
    Plan::Free,
    Plan::Founder,
  ]

  def self.currency
    :jpy
  end

  def self.free?
    false
  end

  def self.features
    []
  end

  def self.find_by_id(id)
    PLANS.detect { |plan| plan.id == id.to_s }
  end

  # Limited plans - nil means no limit.
  def self.max_num_ideas
    nil
  end

  def self.can_export?
    true
  end

  def self.can_notify?
    true
  end

  def self.can_publish_ideas?
    true
  end

  # Used to indicate whether this plan is 'coming soon'.
  def self.is_live?
    true
  end

  def self.can_see_financials?
    true
  end

  def self.free_trial_days
    0
  end

end
