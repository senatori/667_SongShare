class AlbumsController < ApplicationController
	
	def new
		@artist = Artist.new
		@song = Song.new
	end
end
