class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include JauntHelper


  def require_login
    unless logged_in?
      flash[:info] = "You must be logged in to access this section"
      redirect_to signup_path # halts request cycle
    end
  end

  def sign_in_and_redirect(resource_or_scope, *args)
    # options  = args.extract_options!
    # scope    = Devise::Mapping.find_scope!(resource_or_scope)
    resource = args.last || resource_or_scope
    log_in(resource)
    redirect_to after_sign_in_path_for(resource)
  end
end
