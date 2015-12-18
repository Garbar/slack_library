module Omniauth
  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:slack] = {
        'provider' => 'slack',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser'
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      }
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content("Slack")
      auth_mock
      click_link "Slack"
    end
  end

end
RSpec.configure do |config|
  config.include Omniauth::Mock
  config.include Omniauth::SessionHelpers, type: :feature
end
OmniAuth.config.test_mode = true
