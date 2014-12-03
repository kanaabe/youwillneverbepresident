Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['FB_APP_ID'], ENV['FB_SECRET_KEY'], {:scope => 'user_photos,user_status'}
end