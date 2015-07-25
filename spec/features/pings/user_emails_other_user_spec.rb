require 'rails_helper'

feature 'user emails other user', %{
  As an authenticated user
  I want to email an alum that is displayed on the map
  So that I can network
} do
  # Acceptance Criteria
  # [] I must be a registered user
  # [] I cannot view map unless I check in (updating my location)
  # [] I can click on a user's name to access their profile page
  # [] I can click on a 'Ping Me!' link on their profile page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:current_location) do
    FactoryGirl.create(:current_location, user_id: user.id)
  end

  scenario 'user pings another user' do
    user2 = FactoryGirl.create(:user)
    sign_in_as(user2)

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content(user2.first_name)
    click_link 'Check In'

    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.class_year)

    click_link "#{user.first_name}"

    expect(page).to have_content("Say hello!")
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.class_year)
    expect(page).to have_content(current_location.address)

    click_button "Ping Me!"

    expect(page).to have_content("Successfully pinged #{user.first_name}.")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
