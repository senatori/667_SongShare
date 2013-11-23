class Artist < ActiveRecord::Base
  
  before_save { self.email = email.downcase }  #makes all emails lowercase db adapters inconsistent with casesens

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: {case_sensitive: false}

  # in addition to validation/encryption magic, creates two "virtual" instance vars: password and password_confirmation
  has_secure_password
  validates :password, length: {minimum: 6}
end
