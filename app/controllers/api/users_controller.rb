class Api::UsersController < Api::BaseController
  skip_before_filter :authenticate_user!
  respond_to :json

  def current
    render json: current_user
  end

  def exists
    render json: { exists: User.exists?(email: params[:email]) }
  end
end
