# Feature: Sign out
#   As a user
#   I want to sign out
#   So I can protect my account from unauthorized access
feature 'Sign out', :omniauth do

  # Scenario: User signs out successfully
  #   Given I am signed in
  #   When I sign out
  #   Then I see a signed out message
  scenario 'user signs out successfully' do
    signin
    expect(page).to have_content("Log Out")
    click_link "Log Out"
    expect(page).to have_content 'See you'
  end

end
