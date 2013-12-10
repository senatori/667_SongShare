require 'open-uri'

class SongsController < ApplicationController

	#POST /songs
	def create
		# Get an instance of the S3 interface.
		AWS.config(access_key_id: 'AKIAILFH7M7B2NFG7SLA',
               secret_access_key: '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')

		s3 = AWS::S3.new

		file = song_params[:file]
		tempParams = song_params
		tempParams.delete(:file)

		@song = Song.new(tempParams)

		if @song.save

			# Upload file
			if(!file.nil?)
				s3obj = s3.buckets['csc667musicshare'].objects[@song.id.to_s + 
						".mp3"].write(file, acl: :public_read)

				# Save public url of newly uploaded file
				uri = s3obj.url_for(:read)
				url = uri.scheme + '://' + uri.host + uri.path
				@song.update(source_url: url)
			end
			
		end

		redirect_to '/albums/' + @song.album_id.to_s + '/edit' 
	end

	#PATCH/PUT /songs/1
	def update

		@song = Song.find(params['id'])

		# Get an instance of the S3 interface.
		AWS.config(access_key_id: 'AKIAILFH7M7B2NFG7SLA',
               secret_access_key: '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')
		s3 = AWS::S3.new

		tempSong = song_params()

		# Upload file, if a new file is being uploaded
		if(!tempSong[:file].nil?)

			#*** Put in code to delete previous upload *****#

			s3obj = s3.buckets['csc667musicshare'].objects[@song.id.to_s + 
					".mp3"].write(song_params[:file], acl: :public_read)

			# Save public url of newly uploaded file
			uri = s3obj.url_for(:read)
			tempSong[:source_url] = uri.scheme + '://' + uri.host + uri.path
			tempSong.delete(:file)
		end

		#update song data in database
		@song.update(tempSong)

		#instantiate a new 'song' object and reload form
		redirect_to '/albums/' + @song.album_id.to_s + '/edit'
	end


	def download
		@song = Song.find(params[:id])
		@file = open(@song.source_url)
		send_file @file, filename: @song.title + '.mp3'
	end
	
	private

  	#for security, prevents someone from adding extra parameters in POST request via curl
  	def song_params
    	params.require(:song).permit(:file, :title, :featured_artists, :is_downloadable,
                                 :track_number, :source_url, :album_id, :artist_id)
  	end

end
