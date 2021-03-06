class ApplicationController < ActionController::Base
    
     before_filter :configure_permitted_parameters, if: :devise_controller?

	  #before_action :authenticate_user!, :except => [:show, :index]



  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation,:user_name,:remember_me) }
   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation,:user_name,:image,:current_password) }
    end

    


end
