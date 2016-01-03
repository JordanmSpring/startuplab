class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    handle_social_callback
  end

  def linkedin
    handle_social_callback
  end

  def twitter
    handle_social_callback
  end

  def failure
    redirect_to root_path
  end

  private
    def handle_social_callback
      @user = User.from_omniauth(request.env['omniauth.auth'])
      @user.save! unless @user.persisted?
      # This will throw if @user is not activated
      sign_in_and_redirect @user, event: :authentication
    end
end