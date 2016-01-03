class StripeService
  attr_accessor :user, :token, :plan

  def initialize(user, token, plan)
    @user          = user
    @token         = token
    @plan          = plan
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  end

  # Creates or updates the user's subscription, depending on their plan.
  def process!
    return if plan == user.plan.id

    params = {
      source: token,
      plan:   plan,
    }

    response = if user.stripe_customer_id.present?
      customer = Stripe::Customer.retrieve(user.stripe_customer_id)
      # This is an existing customer, down-grading to free.
      if plan == Plan::Free.id
        customer.cancel_subscription().tap do |response|
          user.update_attribute(:plan, plan)
        end
      else
        # This is an existing customer, changing their paid plan.
        customer.update_subscription(params).tap do |response|
          user.update_attribute(:plan, plan)
        end
      end

    elsif plan == Plan::Free.id
      # This is a first-time customer signing up for free.
      user.update_attribute(:plan, plan)

    else
      # This is a new customer, signing up for a paid plan.
      Stripe::Customer.create(params.merge(email: user.email)).tap do |response|
        user.update_attributes(stripe_customer_id: response.id, plan: plan)
      end
    end
  end

end