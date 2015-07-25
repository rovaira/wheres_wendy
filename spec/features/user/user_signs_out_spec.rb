require 'rails_helper'

feature 'user signs out', %{
  As an authenticated user
  I want to sign out
  So that my identity is forgotten about on the machine I'm using
} do
  # Acceptance Criteria
  # * If I'm signed in, i have an option to sign out
  # * When I opt to sign out, I get a confirmation that my identity has been
  #   forgotten on the machine I'm using

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user signs out' do
    sign_in_as(user)

    within(".show-for-large-only") do
      click_link "Sign Out"
    end

    expect(page).to have_content('Signed out successfully')
  end

  scenario 'unauthenticated user attempts to sign out' do
    visit '/'
    expect(page).to_not have_content('Sign Out')
  end
end
