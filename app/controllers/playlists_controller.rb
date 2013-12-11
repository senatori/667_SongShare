class PlaylistsController < ApplicationController

	def show
		#find playlist by given 'id'
		@playlist = Playlist.find(params['id'])

		#find fan who created playlist
		@fan = Fan.find(@playlist.fan_id)

		#find songs that belong to playlist
		@songs = Array.new
		playlist_songs = PlaylistSong.where(playlist_id: @playlist.id)
		playlist_songs.each do |playlist_song|
			song = Song.find(playlist_song.song_id)
			@songs.push(song)
		end
	end
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

  #POST '/playlists/add_song'
	def add_song
    song_id= params[songid]
    playlist_name= params[playlistname]
  end

end
