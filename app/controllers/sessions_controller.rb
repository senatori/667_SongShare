class SessionsController < ApplicationController

	#used for facebook auth
  def create
  	puts '*********HERE*********'
    fan = Fan.from_omniauth(env["omniauth.auth"])
    session[:fan_id] = fan.id
    redirect_to root_url
  end

  def destroy
    session[:fan_id] = nil
    redirect_to root_url
  end
end