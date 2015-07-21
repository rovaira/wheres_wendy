# require 'rails_helper'
#
# describe User do
#   it { should have_valid(:email).when('user@example.com') }
#   it { should have_valid(:email).when('another@gmail.com') }
#   it { should_not have_valid(:email).when('') }
#   it { should_not have_valid(:email).when('user') }
#   it { should_not have_valid(:email).when('users@com') }
#   it { should_not have_valid(:email).when('users.com') }
#   it { should_not have_valid(:email).when('usersuser@anothername123') }
#
#   it 'has a matching password confirmation for the password' do
#     user = User.new
#     user.password = 'password'
#     user.password_confirmation = 'anotherpassword'
#
#     expect(user).to_not be_valid
#     expect(user.errors[:password_confirmation]).to_not be_blank
#   end
#
#   it { should have_valid(:first_name).when('Wendy') }
#   it { should_not have_valid(:first_name).when('') }
#   it { should_not have_valid(:first_name).when(nil) }
#
#   it { should have_valid(:last_name).when('Wellesley') }
#   it { should_not have_valid(:last_name).when('') }
#   it { should_not have_valid(:last_name).when(nil) }
#
#   it { should have_valid(:class_year).when(2009) }
#   it { should_not have_valid(:class_year).when(1) }
#
#   it { should have_valid(:blurb).when('I <3 Sunday Sundaes') }
#   it { should have_valid(:blurb).when('2.4 mi around Lake Waban') }
# end
