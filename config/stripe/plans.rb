Stripe.plan :starter do |plan|
  plan.name     = 'Starter'
  plan.amount   = 0
  plan.interval = 'month'
  plan.currency = 'jpy'
end

Stripe.plan :entrepreneur do |plan|
  plan.name     = 'Entrepreneur'
  plan.amount   = 1000
  plan.interval = 'month'
  plan.currency = 'jpy'
end

Stripe.plan :founder do |plan|
  plan.name     = 'Founder'
  plan.amount   = 2000
  plan.interval = 'month'
  plan.currency = 'jpy'
end
