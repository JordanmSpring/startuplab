class PaymentsController < ApplicationController
  include PathsHelper

  # CSRF protection doesn't play nicely with angular/POST from Stripe.
  skip_before_filter :verify_authenticity_token, only: :create

  before_action :authenticate_user!

  def create
    service  = StripeService.new(current_user, params[:stripeToken], params[:plan_id])

    begin
      service.process!
    rescue Stripe::InvalidRequestError => e
      flash[:error] = e.message
      redirect_to upgrade_error_path and return
    end

    redirect_to after_upgrade_path
  end

end
