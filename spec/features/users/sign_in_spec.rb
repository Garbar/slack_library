# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
feature 'Sign in', :omniauth do

  # Scenario: User can sign in with valid account
  #   Given I have a valid account
  #   And I am not signed in
  #   When I sign in
  #   Then I see a success message
  scenario "user can sign in with valid account" do
    signin
    expect(page).to have_content("Slack")
  end

  scenario 'user is on book page after signin from book page' do
    book = create(:book)
    visit book_path(book)
    auth_mock
    click_on 'Slack'
    expect(current_path).to eq book_path(book)
  end

  # Scenario: User cannot sign in with invalid account
  #   Given I have no account
  #   And I am not signed in
  #   When I sign in
  #   Then I see an authentication error message
  scenario 'user cannot sign in with invalid account' do
    OmniAuth.config.mock_auth[:slack] = :invalid_credentials
    OmniAuth.config.on_failure = Proc.new { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }
    visit root_path
    expect(page).to have_content("Slack")
    click_link "Slack"
    expect(page).to have_content('Authentication with Slack was canceled. Please try again.')
  end
end
