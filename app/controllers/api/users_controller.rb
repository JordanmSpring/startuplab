class Api::UsersController < Api::BaseController
  skip_before_filter :authenticate_user!
  respond_to :json

  def current
    render json: current_user
  end

  def exists
    if User.exists?(email: params[:email])
      head :ok
    else
      head :not_found
    end
  end
end
