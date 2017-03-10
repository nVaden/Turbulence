class ApplicationController < ActionController::Base
	before_filter :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) << :image << :username
  	devise_parameter_sanitizer.for(:account_update) << :image << :username
  end

end
