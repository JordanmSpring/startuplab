class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    @user.save! unless @user.persisted?
    # This will throw if @user is not activated
    sign_in_and_redirect @user, event: :authentication
  end

  def linkedin
    @user = User.from_omniauth(request.env['omniauth.auth'])
    @user.save! unless @user.persisted?
    # This will throw if @user is not activated
    sign_in_and_redirect @user, event: :authentication
  end

  def failure
    redirect_to root_path
  end
end