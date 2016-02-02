class Api::BaseController < ApplicationController
  before_action :authenticate_user!

  # Order is important here - later rescue_from() calls take precedence over earlier ones.
  rescue_from Exception do |exception|
    render json: { error: 'unexpected error' }, status: :internal_server_error
  end if Rails.env.production? || Rails.env.staging?

  rescue_from Pundit::NotAuthorizedError do |exception|
    render json: { error: 'forbidden' }, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: 'not found' }, status: :not_found
  end

end
