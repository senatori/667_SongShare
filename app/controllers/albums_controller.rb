class AlbumsController < ApplicationController
	
	def new
		@artist = Artist.first
		@song = Song.new
		@album = Album.new
	end

	def create
		@artist = Artist.find(album_params['artist_id'])
		# params['album']['artist'] = {artist: @artist}
		# puts '********' + params.to_s + '*********'
		# puts @artist.name + '*******'
		@album = Album.new(album_params())
		@album.save
		@song = Song.new
		render 'new'
	end

	private

	def album_params
    params.require(:album).permit(:title, :release_date, :genre,
                                 :credits, :album_artwork_url, :artist_id)
  end
end
