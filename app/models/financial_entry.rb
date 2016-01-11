class FinancialEntry < ActiveRecord::Base

  GROUPS = [
    GROUP_ASSETS           = 'assets',
    GROUP_LIABILITIES      = 'liabilities',
    GROUP_FOUNDERS_CAPITAL = 'founders capital',
    GROUP_METRICS          = 'metrics',
    GROUP_CASH_INFLOWS     = 'cash inflows',
    GROUP_CASH_OUTFLOWS    = 'cash outflows',
    # These are in the main canvas.
    GROUP_CASH_COSTS       = 'costs',
    GROUP_CASH_REVENUES    = 'revenues',
  ]

  belongs_to :idea
  has_one    :user, through: :idea

  validates :group,
             presence:  true,
             inclusion: { in: GROUPS }

  validates :name,
             presence: true

  validates :value,
             presence:     true,
             numericality: { greater_than_or_equal_to: 0 }

  def value
    self[:value].try(:round, 2)
  end
end
