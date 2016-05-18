Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV["GOOGLE_JAUNT_CLIENT_ID"], ENV["GOOGLE_JAUNT_API_KEY"]
end
