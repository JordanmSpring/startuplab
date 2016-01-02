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
      '1 public canvas',
    ]
  end
end