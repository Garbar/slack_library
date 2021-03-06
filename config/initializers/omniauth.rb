Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, "2692829465.15929880981", ENV["SLACK_APP_SECRET"], scope: "identify,read,post", team: 'T02LCQDDP'
end
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
