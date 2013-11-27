class SongsController < ApplicationController

	def upload
		# Get an instance of the S3 interface.
		s3 = AWS::S3.new

		# Upload file.
		s3obj = s3.buckets['csc667musicshare'].objects[song_params[:title] + 
				".mp3"].write(song_params[:file], acl: :public_read)

		# Save public url of newly uploaded file
		tempSong = song_params()
		uri = s3obj.url_for(:read)
		tempSong[:source_url] = uri.scheme + '://' + uri.host + uri.path
		tempSong.delete(:file)

		#add song data to database
		@song = Song.new(tempSong)
		@song.save

		render 'tests/list_songs'

	end

	private

  #for security, prevents someone from adding extra parameters in POST request via curl
  def song_params
    params.require(:song).permit(:file, :title, :featured_artists, :is_downloadable,
                                 :track_number, :source_url, :album, :artist)
  end

end
