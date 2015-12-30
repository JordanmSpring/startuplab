module ActiveAdmin
  class BaseController

    def authenticate_user!
      raise Pundit::NotAuthorizedError unless current_user.is_admin?
    end

  end
end