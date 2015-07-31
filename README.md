![Build Status](https://codeship.com/projects/ffd59880-0ec0-0133-36c0-0ac2adc2b302/status?branch=master)![Code Climate](https://codeclimate.com/github/rovaira/wheres_wendy.png)

## Where's Wendy?
Find nearby Wellesley alums and network!
This app is intended to help you connect with Wellesley alums near you.
With the ability to see your location on a map, as well as other signed in users, you can ping those nearby via email or text.

## Live App Hosted on Heroku
[whereswendy.herokuapp.com](https://whereswendy.herokuapp.com)

## Mobile Views
Email notification when a user pings another user
![alt](https://s3.amazonaws.com/wheres-wendy-production/static/iphone03.png)

Text notifications when a user pings another user
![alt](https://s3.amazonaws.com/wheres-wendy-production/static/iphone02.png)
![alt](https://s3.amazonaws.com/wheres-wendy-production/static/iphone04.png)

## Tablet View
![alt](https://s3.amazonaws.com/wheres-wendy-production/static/ipad01.jpg)


## Desktop Views
![alt](https://s3.amazonaws.com/wheres-wendy-production/static/readme_desktop01.png)
![alt](https://s3.amazonaws.com/wheres-wendy-production/static/readme_desktop03.png)

## ER Diagrams and Schema Structure
- Single Table Inheritance between User and Ping to demonstrate that both sender and receiver come from the User model
- 1 to 1 relationship between User and CurrentLocation, which is dependent: :destroy
![alt](https://s3.amazonaws.com/wheres-wendy-production/static/Where%27s+Wendy%3F+-+ER+Diagrams.png)

## Ruby version:
2.2.0

## System dependencies (gems):
- gem 'geocoder'
- gem 'gmaps4rails'
- gem 'twilio-ruby'
- gem 'mailcatcher'

Mailcatcher is NOT included in the Gemfile and instead should be added via your console:
```
$ gem install mailcatcher && mailcatcher
```

Please include the following in your development.rb:
```
# config/development.rb
Rails.application.configure do
  # mailcatcher config
  #   to view emails generated in development:
  #   `gem install mailcatcher && mailcatcher`
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: "localhost",
    port: 1025
  }

  config.action_mailer.default_url_options = {
    host: "localhost",
    port: 3000
  }
end
```

## Notes:
Twilio text messages in the development environment still need to be implemented.
Text messages work fine in production.

### Get started:
```
bundle
```

### Boot up the database:
```
rake db:migrate
```

### Run the test suite:
```
rake
```

### Deploy:
On a clean MASTER branch, run:
```
git push heroku master
```
