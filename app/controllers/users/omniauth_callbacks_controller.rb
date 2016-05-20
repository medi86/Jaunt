class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    generic_callback('google_oauth2')
  end

  def generic_callback( provider )
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:success] = "You have successfully logged in to Jaunt"
      sign_in_and_redirect @user
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end
end

