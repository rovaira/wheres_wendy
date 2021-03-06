require 'rails_helper'

feature 'user registers', %{
  As a prospective user
  I want to create an account
  So that I can post items and review them
} do

  # Acceptance Criteria:
  # [X] I must specify a valid email address, username,
  #   password, and password confirmation
  # [X] If I don't specify the required information, I am presented with
  #   an error message

  scenario 'provide valid registration information' do
    visit root_path

    within("#registration-modal") do
      # need to validate for @wellesley.edu or @alum.wellesley.edu email
      fill_in 'Email', with: 'wendy@wellesley.edu'

      fill_in 'First Name', with: 'Wendy'
      fill_in 'Last Name', with: 'Wellesley'

      fill_in 'Class Year', with: '2009'

      fill_in 'Blurb', with: 'Sunday Sundaes'

      fill_in 'Phone', with: '6179393969'
      # share phone number - checkbox
      check 'Share your number?'

      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Sign up'
    end

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit root_path

    within("#registration-modal") do
      fill_in 'Email', with: 'wendy'
    end

    expect(page).to_not have_content('Sign Out')
  end
end
