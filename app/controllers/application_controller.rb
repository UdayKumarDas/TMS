class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_devise_permitted_parameters, if: :devise_controller?

   protect_from_forgery

 def after_sign_in_path_for(resource)
    # request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    "/projects"
 end


  protected

  def configure_devise_permitted_parameters
    permitted_params = [:email, :password, :password_confirmation, :name,:dob,:company_name,:profile_picture]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(permitted_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(permitted_params) 
      }
    end
  end
end
