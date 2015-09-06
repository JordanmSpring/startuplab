class Api::UsersController < Api::BaseController
  skip_before_filter :authenticate_user!
  respond_to :json

  def current
    if current_user
      render json: UserExhibit.new(current_user)
    else
      render json: {}
    end
  end

  def exists
    render json: { exists: User.exists?(email: params[:email]) }
  end
end
