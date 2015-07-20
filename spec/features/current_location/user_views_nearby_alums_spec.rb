require 'rails_helper'

feature 'user views map of nearby alums', %{
  As an authenticated user
  I want to view the map by checking in
  So that I can see if any alums are nearby
} do
  # Acceptance Criteria
  # [] I must be a registered user
  # [] I cannot view map unless I check in (updating my location)
  # [] I should see myself on the map as well

  let!(:user) { FactoryGirl.create(:user) }
  let!(:current_location) do FactoryGirl.create(:current_location,
    user_id: user.id)

  scenario 'user checks in' do
    sign_in_as(user)
    click_link "Check In"

    expect(page).to have_content("Here's Wendy!")
    expect(page).to have_content(current_location.user.first_name)
  end
end
