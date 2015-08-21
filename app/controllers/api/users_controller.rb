class Api::UsersController < Api::BaseController
  respond_to :json

  def current
    render json: current_user
  end
end
