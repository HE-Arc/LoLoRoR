class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
  
  LOL_WRAPPER = LolWrapper.new
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :get_regions
  
 
  def set_locale
    I18n.locale = :fr
  end
   
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
  
  def get_regions
    @regions = LOL_WRAPPER.region_list
  end
  
end
