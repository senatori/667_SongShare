class SessionsController < ApplicationController

	#used for facebook auth
  def create
    fan = Fan.from_omniauth(env["omniauth.auth"])
    session[:fan_id] = fan.id
    redirect_to '/fans/' + current_fan.id.to_s
  end

  def destroy
    session[:fan_id] = nil
    redirect_to root_url
  end
end