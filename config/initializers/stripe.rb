Stripe.api_key                    = ENV['STRIPE_SECRET_KEY']
StripeEvent.authentication_secret = ENV['STRIPE_WEBHOOK_SECRET']

# Handle subscription deletion.
StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.deleted', StripeExpiryService.new
end

# This is used purely for testing webhooks manually during development.
# The stripe_event gem tries to fetch the event from Stripe, and fails
# with an unauthorised error if it can't find the real event.
#
# https://github.com/integrallis/stripe_event/issues/8#issuecomment-65572876
StripeEvent.event_retriever = lambda do |params|
  if params[:livemode]
    ::Stripe::Event.retrieve(params[:id])
  elsif !Rails.env.production?
    # This will return an event as is from the request (security concern in production)
    ::Stripe::Event.construct_from(params.deep_symbolize_keys)
  end
end
