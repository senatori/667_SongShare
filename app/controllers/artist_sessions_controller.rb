class ArtistSessionsController < ApplicationController

  #called via GET /signin
  #named route: signin_path
  #purpose: page for a new session
  def new
  end

  #called via POST /sessions
  #named route: sessions_path
  #purpose: creates a new session
  def create
    artist = Artist.find_by(email: params[:artist_session][:email].downcase)
    if (artist && artist.authenticate(params[:artist_session][:password])) #authenticate provided by has_secure_password & bcrypt
      # Sign the user in and redirect to the user's show page.
      sign_in artist #defined in ArtistSessionHelper
      redirect_to artist

    else
      # Create an error message and re-render the signin form.
      flash[:error] = 'Invalid email/password combination' # use flash.now[:error] if error message persists
      render 'new'
    end

  end

  #called via DELETE /signout
  #named route: signout_path
  def destroy
    sign_out #defined in ArtistSessionHelper
    redirect_to root_url
  end

end
