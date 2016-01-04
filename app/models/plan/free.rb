class Plan::Free < Plan
  def self.id
    'free'
  end

  def self.name
    'Free'
  end

  def self.amount
    0
  end

  def self.free?
    true
  end

  def self.features
    [
      '1 private canvas',
    ]
  end

  def self.max_num_ideas
    1
  end

  def self.can_export?
    false
  end

  def self.can_publish_ideas?
    false
  end

  def self.can_notify?
    false
  end
end
