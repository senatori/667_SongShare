class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #used for facebook omniauth gem
  private
  def current_fan
    @current_fan ||= Fan.find(session[:fan_id]) if session[:fan_id]
  end
  helper_method :current_fan

end
