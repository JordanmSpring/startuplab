class Api::SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication
  respond_to :json

  # TODO: As devise just uses respond_with, we could create a responder for current_user and not have
  # to overide this
  def create
    self.resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render json: {
      success: true,
      info: "Logged in",
      user: UserExhibit.new(current_user)
    }
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_out
    render json: {
      success: true,
      info: "Logged out"
    }
  end

  def failure
    render status: 401, json: {
      success: false,
      info: "Login Credentials Failed"
    }
  end
end
