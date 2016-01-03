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
      '1 canvas',
    ]
  end

  def self.max_num_ideas
    1
  end
end