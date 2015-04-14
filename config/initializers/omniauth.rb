Rails.application.config.middleware.use OmniAuth::Builder do
	require "omniauth-twitter" 
	provider :twitter, ENV["twitter_api_key"], ENV["twitter_api_secret"]
	# Set the default hostname for omniauth to send callbacks to.
	OmniAuth.config.full_host = ENV["host_url"]
end