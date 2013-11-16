class Fan < ActiveRecord::Base

	#used for facebook omniquth gem
	def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |fan|
      fan.provider = auth.provider
      fan.uid = auth.uid
      fan.name = auth.info.name
      fan.oauth_token = auth.credentials.token
      fan.oauth_expires_at = Time.at(auth.credentials.expires_at)
      fan.save!
    end
  end
end
