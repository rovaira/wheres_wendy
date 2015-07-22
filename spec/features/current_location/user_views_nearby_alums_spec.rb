require 'rails_helper'

feature 'user views profile', %Q{
  As an authenticated user
  I want to view another user's profile by clicking on their name on the map
  So that I can get a quick view of their info
} do

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'specify valid credentials' do
    current_location = FactoryGirl.create(:current_location, user_id: user.id)
    user2 = FactoryGirl.create(:user)
    sign_in_as(user2)

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content(user2.first_name)
    click_link 'Check In'

    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.class_year)
  end
end
