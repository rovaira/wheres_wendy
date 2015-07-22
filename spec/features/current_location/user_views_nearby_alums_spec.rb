require 'rails_helper'

feature 'user views nearby alums', %{
  As an authenticated user
  I want to see a map that has nearby alums displayed
  So that I can see if anyone is near me to network
} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:current_location) do
    FactoryGirl.create(:current_location, user_id: user.id)
  end

  scenario 'specify valid credentials' do
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
