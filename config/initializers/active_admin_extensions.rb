module ActiveAdmin
  class BaseController

    def authenticate_user!
      raise Pundit::NotAuthorizedError unless current_user.admin?
    end

  end
end
