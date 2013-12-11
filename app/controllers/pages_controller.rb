class PagesController < ApplicationController
	
	def index
		@albums = Album.order(created_at: :desc)
		@albums2 = Album.order(release_date: :desc)
		@artist = Artist.find(@albums.artist_id)
		@artist2 = Artist.find(@albums2.artist_id)
	end
	
	def artist
	end
	
	def album
	end
	
	def playlist
	end
	
	def fan
	end
end
