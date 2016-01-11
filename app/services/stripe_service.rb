class StripeService
  attr_accessor :user, :token, :plan_id

  def initialize(user, token, plan_id)
    @user    = user
    @token   = token
    @plan_id = plan_id
  end

  # Creates or updates the user's subscription, depending on their plan.
  def process!
    return if plan_id == user.plan.id

    params = {
      source: token,
      plan:   plan_id,
    }

    response = if user.stripe_customer_id.present?
      customer = Stripe::Customer.retrieve(user.stripe_customer_id)
      # This is an existing customer, down-grading to free.
      if plan_id == Plan::Free.id
        customer.cancel_subscription().tap do |response|
          user.update_attribute(:plan_id, plan_id)
        end
      else
        # This is an existing customer, changing their paid plan.
        customer.update_subscription(params).tap do |response|
          user.update_attribute(:plan_id, plan_id)
        end
      end

    elsif plan_id == Plan::Free.id
      # This is a first-time customer signing up for free.
      user.update_attribute(:plan_id, plan_id)

    else
      # This is a new customer, signing up for a paid plan.
      Stripe::Customer.create(params.merge(email: user.email)).tap do |response|
        user.update_attributes(stripe_customer_id: response.id, plan_id: plan_id)
      end
    end
  end

end