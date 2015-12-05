Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :github, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret
  # provider :slack, "2692829465.15929880981", "f61671a1bbd7d48fcf5147271dbea5e1", scope: 'client'
  provider :slack, "2692829465.15929880981", ENV["SLACK_APP_SECRET"], scope: "identify,read,post", team: 'T02LCQDDP'
end
