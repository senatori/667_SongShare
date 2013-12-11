class PagesController < ApplicationController
	
	def index
		@albums = Album.order(created_at: :desc)
		@albums2 = Album.order(release_date: :desc)
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
