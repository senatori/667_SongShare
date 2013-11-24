class ArtistsController < ApplicationController


  def new
    @artist = Artist.new
  end

  def create

    @artist = Artist.new(artist_params())
    if @artist.save
      # Handle a successful save.
      #redirect_to @artist or somewhere
    else
      #errors are in the artist.errors hash, you can print them all out via artist.errors.full_messages
      render 'new'
    end
  end

  private

  #for security, prevents someone from adding extra parameters in POST request via curl
  def artist_params
    params.require(:artist).permit(:name, :email, :password,
                                 :password_confirmation)
  end

end
