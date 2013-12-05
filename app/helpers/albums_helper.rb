module AlbumsHelper
  def aws_album_art_upload(uploaded_io, status)

    AWS.config(access_key_id: AMAZONKEYS["stevens_keys"]["access_key_id"],
               secret_access_key: AMAZONKEYS["stevens_keys"]["secret_access_key"],
               region: 'us-east-1')

    s3 = AWS::S3.new

    if(!uploaded_io.nil?)
      img_full_path= Rails.root.join('public', 'uploads', 'albumart', uploaded_io.original_filename)
      content_type= uploaded_io.content_type()

      File.open(img_full_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end

      key= @album.id.to_s + '.jpg' #name of the file
      photo_obj= s3.buckets['songsharealbum'].objects[key]
      photo_obj.write(:file => img_full_path, :acl=> :public_read)


      # Save public url of newly uploaded file
      uri = photo_obj.url_for(:read)
      img_url = uri.scheme + '://' + uri.host + uri.path

      @album.update_attribute(:album_artwork_url, img_url)

      File.delete(img_full_path) #delete the file from rails server (Heroku) when were done with it

    else #if no album art specified,
      if(status == new) #set image to default if album was just created, IF not, we leave it alone(might be default, might not)
        photo_obj= s3.buckets['songsharealbum'].objects['default.jpg']
        uri = photo_obj.url_for(:read)
        img_url = uri.scheme + '://' + uri.host + uri.path

        @album.update_attribute(:album_artwork_url, img_url)
      end

    end

  end

end

