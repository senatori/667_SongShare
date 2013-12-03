class AlbumsController < ApplicationController
	
	#GET albums/new
	def new
		@artist = Artist.first
		@song = Song.new
		@album = Album.new
	end

	#GET albums/1/edit
	def edit
		@album = Album.find(params['id'])
		@artist = Artist.find(@album.artist_id)
		@song = Song.new

		@submit = 'Update Album'
	end

	def create

		#save album
		@album = Album.new(album_params())
		@album.save

		@submit = 'Create'
		#instantiate a new 'song' object and reload form
		render 'edit'
	end

	private

	def album_params
    params.require(:album).permit(:title, :release_date, :genre,
                                 :credits, :album_artwork_url, :artist_id)
  end
end
