class ArtistsController < ApplicationController


  def new
    @artist = Artist.new
  end

  def create

    @artist = Artist.new(artist_params())
    if @artist.save
      # Handle a successful save.
      sign_in @artist #uppon successful account creation; sign them in automatically
      #flash[:success] = "Welcome to the Sample App!"
      redirect_to @artist #redirect_to artist_path(@user)
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

  def show #will be called after artist sign up and artist sign in
    @user = Artist.find(params[:id])  #Artist.find(id)

  end
end
