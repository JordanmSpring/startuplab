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
    params = {
      source: token,
      plan:   plan,
    }

    response = if user.stripe_customer_id.present?
      customer = Stripe::Customer.retrieve(user.stripe_customer_id)
      customer.update_subscription(params).tap do |response|
        user.update_attribute(:stripe_plan, plan)
      end
    else
      Stripe::Customer.create(params.merge(email: user.email)).tap do |response|
        user.update_attributes(stripe_customer_id: response.id, stripe_plan: plan)
      end
    end

    Rails.logger.debug response.inspect

    return response
  end

end