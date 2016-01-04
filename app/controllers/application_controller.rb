class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :push_clientside_vars

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:accept_invitation) << :name
  end

  def push_clientside_vars
    gon.push(stripe_publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'])
    gon.push(flashError: flash[:error]) if flash[:error]
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
end
