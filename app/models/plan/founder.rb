class Plan::Founder < Plan
  def self.id
    'founder'
  end

  def self.name
    'Founder'
  end

  def self.amount
    2000
  end

  def self.features
    [
      'Unlimited private & public canvases',
      'Ability to export business plan',
      'Automated and exported financials',
      'Notifications and comments',
      'And much more',
    ]
  end
end