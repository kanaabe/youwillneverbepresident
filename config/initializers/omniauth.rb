Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['FB_APP_ID_TEST'], ENV['FB_SECRET_KEY_TEST'], {:scope => 'user_photos,user_status'}
end