OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '173123302892053', '70680a2ea29825c1f37695edda835950'
end