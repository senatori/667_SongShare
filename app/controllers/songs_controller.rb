class SongsController < ApplicationController

	#POST /songs
	def create
		# Get an instance of the S3 interface.
		s3 = AWS::S3.new

		tempSong = song_params()
		# Upload file.
		if(!tempSong[:file].nil?)
			s3obj = s3.buckets['csc667musicshare'].objects[song_params[:title] + 
					".mp3"].write(song_params[:file], acl: :public_read)

			# Save public url of newly uploaded file
			uri = s3obj.url_for(:read)
			tempSong[:source_url] = uri.scheme + '://' + uri.host + uri.path
			tempSong.delete(:file)
		end
		#add song data to database
		@song = Song.new(tempSong)
		@song.save

		redirect_to '/albums/' + @song.album_id.to_s + '/edit' 
	end

	#PATCH/PUT /songs/1
	def update

		# Get an instance of the S3 interface.
		s3 = AWS::S3.new

		tempSong = song_params()
		# Upload file.
		if(!tempSong[:file].nil?)

			#*** Put in code to delete previous upload *****#

			s3obj = s3.buckets['csc667musicshare'].objects[song_params[:title] + 
					".mp3"].write(song_params[:file], acl: :public_read)

			# Save public url of newly uploaded file
			uri = s3obj.url_for(:read)
			tempSong[:source_url] = uri.scheme + '://' + uri.host + uri.path
			tempSong.delete(:file)
		end

		#update song data in database
		@song = Song.find(params['id'])
		@song.update(tempSong)

		#instantiate a new 'song' object and reload form
		redirect_to '/albums/' + @song.album_id.to_s + '/edit'
	end

	
	private

  	#for security, prevents someone from adding extra parameters in POST request via curl
  	def song_params
    	params.require(:song).permit(:file, :title, :featured_artists, :is_downloadable,
                                 :track_number, :source_url, :album_id, :artist_id)
  end

end
