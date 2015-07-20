require 'rails_helper'

feature 'user views profile', %Q{
  As an authenticated user
  I want to view another user's profile by clicking on their name on the map
  So that I can get a quick view of their info
} do
  scenario 'specify valid credentials' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    sign_in_as(user)

    expect(page).to have_content('Signed in successfully')
    click_link 'Check In'

    expect(page).to have_content(user2.first_name)

    click_link "#{user2.first_name}"

    expect(page).to have_content(user2.first_name)
    expect(page).to have_content(user2.last_name)
    expect(page).to have_content(user2.class_year)
  end
end
