class FansController < ApplicationController
  def show
	if !current_fan
		render 'pages/index'
	end
	@playlists = Playlist.where(fan_id: current_fan.id)
  end
end
