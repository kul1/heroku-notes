
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity,
    :fields => [:code, :email],
    :on_failed_registration=> lambda { |env|
      IdentitiesController.action(:new).call(env)
  }
  provider :facebook, ENV['FACEBOOK_API'], ENV['FACEBOOK_KEY']
	provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end
