class PagesController < ApplicationController
	
	def index
		@albums = Album.order(release_date: :desc)
		@artist = Artist.find(@album.artist_id)
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
