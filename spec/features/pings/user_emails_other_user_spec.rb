# require 'rails_helper'
#
# feature 'user views map of nearby alums', %{
#   As an authenticated user
#   I want to email an alum that is displayed on the map
#   So that I can network
# } do
#   # Acceptance Criteria
#   # [] I must be a registered user
#   # [] I cannot view map unless I check in (updating my location)
#   # [] I should see myself on the map as well
#
# let!(:user) { FactoryGirl.create(:user) }
# let!(:current_location) do FactoryGirl.create(:current_location,
#   user_id: user.id)
# end
#
#   scenario 'user emails other user' do
#     visit root_path
#     sign_in_as(user)
#     expect(page).to have_content(user.first_name)
#   end
# end
