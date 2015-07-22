require 'rails_helper'

feature 'user signs in', %Q{
  As a signed up user
  I want to sign in
  So that I can regain access to my account
} do

  let!(:user) { FactoryGirl.create(:user) }
   
  scenario 'specify valid credentials' do

    visit root_path

    within(".show-for-medium-up") do
      click_link "Sign In"
    end

    within('#sign-in-modal') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')
  end

  scenario 'specify invalid credentials' do
    visit root_path

    within(".show-for-medium-up") do
      click_link "Sign In"
    end

    within('#sign-in-modal') do
      click_button 'Log in'
    end

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Sign Out')
  end
end
