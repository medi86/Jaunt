class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def google_oauth2
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     flash[:info] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
  #     sign_in_and_redirect @user
  #   else
  #     session["devise.google_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  def facebook
    generic_callback( 'facebook' )
  end

  def google_oauth2
    generic_callback( 'google_oauth2' )
  end

  def generic_callback( provider )
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:info] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.capitalize
      sign_in_and_redirect @user
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end

