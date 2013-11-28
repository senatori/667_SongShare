module ArtistSessionsHelper

  def sign_in(artist)
    remember_token = Artist.new_remember_token #creates a new session token each time artist logs in
    cookies.permanent[:remember_token] = remember_token #places session token as a cookie(rails specific)on artists browser
    artist.update_attribute(:remember_token, Artist.encrypt(remember_token)) #updates db artist record with new session token

    self.current_artist = artist # not necessary but needed to call sign_in without a redirect
    # also note that this assignment needs to be defined

    #to note:
    #cookies.permanent line is equivalent to:
    #cookies[:remember_token] = { value: remember_token, expires: 20.years.from_now.utc }
  end

  def signed_in?
    !current_artist.nil? # if current_artist funciton returns a value (is not empty), then (true), you are signed in
  end

  def current_artist=(artist) #essentially a setter method
    @current_artist = artist
  end

  def current_artist  #essentially a getter method
    remember_token = Artist.encrypt(cookies[:remember_token])
    @current_artist ||= Artist.find_by(remember_token: remember_token) # @current_artist = @current_artist || Artist.find_by
    #line above prevents us from querrying the db if theres already a value in current_artist.
  end

  def sign_out
    self.current_artist = nil
    cookies.delete(:remember_token)
  end
end
