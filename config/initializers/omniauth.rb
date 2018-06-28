OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_CONFIG["app_id"], FACEBOOK_CONFIG["secret"], scope: "public_profile, email", info_fields: "id,last_name,email,name,link"
  provider :google_oauth2, GOOGLE_CONFIG["CLIENT_ID"], GOOGLE_CONFIG["CLIENT_SECRET"]
end
