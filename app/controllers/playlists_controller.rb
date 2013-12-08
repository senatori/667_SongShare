class PlaylistsController < ApplicationController

	#POST playlists/
	def create
		@playlist = Playlist.new(fan_id: current_fan.id, title: params[:playlist]['title'])
		@playlist.save

		# if song_id is provided create new 'playlist_song'
		if !params[:playlist]['title'].nil?
			@playlist_song = PlaylistSong.new(playlist_id: @playlist.id, song_id: params[:playlist]['song_id'])
			@playlist_song.save
		end

		if !params[:playlist]['album_id'].nil?
			redirect_to '/albums/' + params[:playlist][:album_id]
		end
	end

	def add_song
	end
end
