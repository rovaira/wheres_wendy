![Build Status](https://codeship.com/projects/ffd59880-0ec0-0133-36c0-0ac2adc2b302/status?branch=master)![Code Climate](https://codeclimate.com/github/rovaira/wheres_wendy.png)

Where's Wendy?
Find nearby Wellesley alums
whereswendy.herokuapp.com

This app is intended to help you connect with Wellesley alums near you.

Ruby version: 2.2.0

System dependencies (gems):
- Geocoder
- Gmaps4rails
- Mailcatacher

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



```
Get started:
bundle

Boot up the database:
rake db:migrate

Run the test suite:
rake

Deploy:
On a clean MASTER branch, run:
git push heroku master
```
