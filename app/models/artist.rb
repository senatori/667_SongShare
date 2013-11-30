class Artist < ActiveRecord::Base

  has_many :albums
  has_many :songs
  
  before_save { self.email = email.downcase }  #makes all emails lowercase db adapters inconsistent with casesens

  #before_create is a callback method. Calls methods passed to it immediately before user is created in db
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: {case_sensitive: false}

  # in addition to validation/encryption magic, creates two "virtual" instance vars: password and password_confirmation
  has_secure_password
  validates :password, length: {minimum: 6}

  #---------------------------------session functionality--------------------------------------
  #defining static/class methods b/c we'll be calling them outside of our User model
  def Artist.new_remember_token
    SecureRandom.urlsafe_base64 #creates a unique 16 char length string identifier A-Z, a-z, 0-9, "-", "_"
  end

  def Artist.encrypt(token)
    #encrypts our 16 char length identifer/token
    Digest::SHA1.hexdigest(token.to_s) #using to_s because tests will pass nil. no bueno
  end

  private

  def create_remember_token
    #self because @user.remember_token is the db column/attribute, and we are inside the User object. Otherwise, Ruby
    #will create a var/object called remember_token.
    self.remember_token = Artist.encrypt(Artist.new_remember_token)
  end

end
