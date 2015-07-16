require 'rails_helper'

feature 'edit_user_registration', %{
  As an authenticated user
  I want to update my information
  So that I can keep my profile up to date
} do
  # Acceptance Criteria
  # [] If I'm signed in, I see a link to edit my profile as a drop down
  # [] When I click the link, I can edit my information via form
  # [] When I submit the form, my information is updated
  # [] I will see a confirmation on my profile page when form is submitted

  scenario 'authenticated user edits profile information' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    expect(page).to have_content('Signed in successfully')

    visit edit_user_registration_path

    fill_in 'user[username]', with: 'newusername'
    fill_in 'user[current_password]', with: user.password

    click_button 'Update'

    expect(page).to have_content('newusername')
    expect(page).to have_content('Your account has been updated successfully.')
  end
end
