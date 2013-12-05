class AlbumsController < ApplicationController
	
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
		@songs = Song.where(album_id: params[:id])
		@artist = Artist.find(@album.artist_id)
	end
	#GET albums/1/edit
	def edit
		if(!signed_in?)
			redirect_to '/artist_signin'

		else
			@artist = Artist.find(@current_artist.id)
			@album = Album.find(params['id'])
			@song = Song.new
		end
	end

	#POST /albums
	def create

		#save album
		@album = Album.new(album_params())
		@album.save

		# @artist = Artist.find(@album.artist_id)
		# @song = Song.new
		
		#instantiate a new 'song' object and reload form
		redirect_to action: 'edit', id: @album.id
	end

	#PATCH/PUT /albums/1
	def update

		#save album
		@album = Album.find(params['id'])
		@album.update(album_params())

		#instantiate a new 'song' object and reload form
		redirect_to action: 'edit', id: @album.id
	end

	private

	def album_params
    params.require(:album).permit(:title, :release_date, :genre,
                                 :credits, :album_artwork_url, :artist_id)
  end
end
