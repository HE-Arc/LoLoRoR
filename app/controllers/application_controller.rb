class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
  
  LOL_WRAPPER = LolWrapper.new
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :get_regions
  before_action :get_lighter_dashboards
  before_action :get_current_playing
  
  rescue_from Lol::InvalidAPIResponse, :with => :render_invalid_response
  
 
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
  
  def get_lighter_dashboards
    if user_signed_in?
      @dashboards_light = current_user.dashboards
    end
  end
  
  def get_current_playing
    if user_signed_in?
      @playingUsers = []
      user_groups = current_user.trackgroups
      user_groups.each do |g|
        g.accounts.each do |u|
          isPlaying = LOL_WRAPPER.get_is_playing(u.idLoL, u.region)
          if isPlaying
            #current_game
            @playingUsers << { pseudoLol: u.pseudoLoL, persoId: 10}
          end
        end
      end
    end
  end
  
  private
  
  def render_invalid_response(exception)
    render :template => "/error/custom_error.html.erb"
  end
end
