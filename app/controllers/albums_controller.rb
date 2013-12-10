class AlbumsController < ApplicationController
  include AlbumsHelper
	#GET albums/new
	def new
		if(!signed_in?)
			redirect_to '/artist_signin'	
		
		else

			@artist = Artist.find(@current_artist.id)
			@song = Song.new
			@album = Album.new
		end
	end

	#GET albums/1
	def show
		@album = Album.find(params[:id])
		@songs = Song.where(album_id: params[:id]).order(:track_number)
		@artist = Artist.find(@album.artist_id)

		#if fan is logged in, load playlist for "add to playlist" function
		if current_fan
			@playlists = Playlist.where(fan_id: current_fan.id)
			@new_playlist = Playlist.new
		end
	end
	#GET albums/1/edit
	def edit
		if(!signed_in?)
			redirect_to '/artist_signin'

		else
			@artist = Artist.find(@current_artist.id)
			@album = Album.find(params['id'])
			@songs = Song.where(album_id: params[:id]).order(:track_number)
			@song = Song.new
		end
	end

	#POST /albums
	def create

		#save album
	    temp_hash= album_params()
	    image_upload_io= temp_hash[:album_artwork_url]
	    temp_hash.delete(:album_artwork_url)
		@album = Album.new(temp_hash)
		@album.save
		id = @album.id

		puts "******* Before album art: id= " + id.to_s + '**************'

    	aws_album_art_upload(image_upload_io, "new")

    	puts "******* After album art: id= " + id.to_s + '**************'

		
		#reload form
		redirect_to action: 'edit', id: id
	end

	#PATCH/PUT /albums/1
	def update
		@album = Album.find(params['id'])

    #housekeeping. we used :album_artwork_url to hold a .jpg file but model expects a string
    temp_hash= album_params()
    image_upload_io= temp_hash[:album_artwork_url]
    temp_hash.delete(:album_artwork_url)

		#save album
		@album.update(temp_hash)

    aws_album_art_upload(image_upload_io, "new")



		#reload form
		redirect_to action: 'edit', id: params['id']

	end

	private

	def album_params
    params.require(:album).permit(:title, :release_date, :genre,
                                 :credits, :album_artwork_url, :artist_id)
  end
end
