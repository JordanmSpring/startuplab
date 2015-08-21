class UsersController < ApplicationController
  respond_to :json

  def current
    render json: current_user
  end
end
