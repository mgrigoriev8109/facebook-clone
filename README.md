## Facebook Clone

A Ruby on Rails clone of the social media website Facebook. 

### Demo

This will be a gif of the website

### Live Version

You can find a [live version of the Facebook Clone here]. Create an account using using your email or by signing-up with your GitHub account, 

*alternatively* 

Log in as a test user using the following credentials:
- email: bob@gmail.com
- password: bobbob

### Using the App

**Setting up your account**
- Sign up with a personal email through the Devise gem, or with a GitHub account through the OmniAuth gem
- Receive email upon sign-up by combining ActionMailer with the Twilio SendGrid add-on
- Upload photos to profile picture using AWS S3 with Active Storage.

**Making friends**
- Send friend requests to other users
- Receive a notification upon getting a friend request
- Requests must be accepted to become friends
- Unfriend users

**Posting, Commenting, Notifications, Liking**
- View what your friends have to say on your news feed
- Post text, url, or images from your profile page
- Comment on posts, or edit/delete comments
- Like comments or posts
- Receive notifications when users like or respond to your posts/comments

**Messaging**
- Send real-time chat messages to friends through Action Cable integrated WebSockets

### Development Features
- Test Driven Development and comprehensive integration testing through the Capybara gem
- Tests running continuously throughout production through the Guard gem.
- Stimulus
- Turbo
- PostgreSQL used in both development and production

### Reflections
