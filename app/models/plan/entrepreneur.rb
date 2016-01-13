class Plan::Entrepreneur < Plan
  def self.id
    'entrepreneur'
  end

  def self.name
    'Entrepreneur'
  end

  def self.amount
    1000
  end

  def self.features
    [
      'Unlimited private and public canvases',
      'Ability to export business plan',
      'Automated and exported financials',
      'Notifications and comments',
    ]
  end

  def self.free_trial_days
    30
  end
end
