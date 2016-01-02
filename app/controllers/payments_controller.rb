class PaymentsController < ApplicationController
  # CSRF protection doesn't play nicely with angular/POST from Stripe.
  skip_before_filter :verify_authenticity_token, only: :create

  before_action :authenticate_user!

  def create
    service  = StripeService.new(current_user, params[:stripeToken], params[:plan])
    response = service.process!

    render text: response.inspect
  end

end
