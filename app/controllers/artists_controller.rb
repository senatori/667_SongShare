class ArtistsController < ApplicationController

#input_image_filename, output_image_filename, max_width, max_height
#Image.resize('big.jpg', 'small.jpg', 40, 40)

  def new
    @artist = Artist.new
  end

  #GET artists/1
  def show #will be called after artist sign up and artist sign in
    @artist = Artist.find(params[:id]) #Artist.find(id)
    #find all albums that belong to this artist
    @albums = Album.where(artist_id: params[:id])
  end

  def create

    uploaded_io= artist_params[:picture]
    temp_param_hash= artist_params
    temp_param_hash.delete(:picture)
    @artist = Artist.new(temp_param_hash)
    if @artist.save
      # Handle a successful save.
      #if Model says form data is okay, upload the image:
      #uploaded_io=params[:artist][:picture]


      AWS.config(access_key_id: AMAZONKEYS["stevens_keys"]["access_key_id"],
                 secret_access_key: AMAZONKEYS["stevens_keys"]["secret_access_key"],
                 region: 'us-east-1')

      s3 = AWS::S3.new

      if(!uploaded_io.nil?)
        img_full_path= Rails.root.join('public', 'uploads', uploaded_io.original_filename)
        content_type= uploaded_io.content_type()
        #uploaded_io.content_type() #returns the type of file (MIME info)
        #uploaded_io.local_path() #the local path where the file orignated from on users PC
        #the crapy doc can be found at: http://ruby-doc.org/stdlib-2.0.0/libdoc/cgi/rdoc/CGI.html

        #using a block ensures that file.close is automatically called, as opposed to using file=File.open, where its not.
        File.open(img_full_path, 'wb') do |file|
          file.write(uploaded_io.read)
        end


        #obj = s3.buckets['my-bucket'].objects['key'] # no request made
        key= @artist.id.to_s + '.jpg' #name of the file
        photo_obj= s3.buckets['songshareartist'].objects[key]
        photo_obj.write(:file => img_full_path, :acl=> :public_read)


        # Save public url of newly uploaded file
        uri = photo_obj.url_for(:read)
        img_url = uri.scheme + '://' + uri.host + uri.path

        @artist.update_attribute(:photo_url, img_url)

        File.delete(img_full_path) #delete the file from rails server (Heroku) when were done with it

      else #if no album art specified, set default
        photo_obj= s3.buckets['songshareartist'].objects['default.jpg']
        uri = photo_obj.url_for(:read)
        img_url = uri.scheme + '://' + uri.host + uri.path

        @artist.update_attribute(:photo_url, img_url)

      end

      sign_in @artist #uppon successful account creation; sign them in automatically
      #flash[:success] = "Welcome to the Sample App!"
      #redirect_to @artist #redirect_to artist_path(@user)
      redirect_to '/artists/' + @artist.id.to_s
    else
      #errors are in the artist.errors hash, you can print them all out via artist.errors.full_messages
      render 'new'
    end
  end

  private

  #for security, prevents someone from adding extra parameters in POST request via curl
  def artist_params
    params.require(:artist).permit(:name, :email, :password,
                                   :password_confirmation, :picture)
  end
end
