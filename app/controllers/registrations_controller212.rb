# class RegistrationsController < ApplicationController

#   before_filter :configure_permitted_parameters, :only => [:create]

#   protected

#     def configure_permitted_parameters
#       devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,:dob,:company_name, :email, :password) }
#     end
# end
