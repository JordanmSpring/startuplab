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
      'Unlimited private and public canvases',
      'Ability to export business plan',
      'Automated and exported financials',
      'Notifications and comments',
    ]
  end
end
