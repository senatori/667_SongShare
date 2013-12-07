class FansController < ApplicationController
  def show
	if !current_fan
		render 'pages/index'
	end
  end
end
