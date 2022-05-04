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
- Create posts from your profile page
- Comment on posts, or edit/delete comments
- Like and Unlike comments or posts
- Receive notifications when users like or respond to your posts/comments

### Development Features
- Utilize Turbo to increase performance 
- Bulma used for styling
-  and comprehensive integration testing performed through the Capybara gem, with Guard gem running in the background to provide continuous test feedback
- PostgreSQL used in both development and production

### Reflections

### Software Development Life Cycle

#### Gathering and Analysis of Requirements

I put myself in the shoes of the user, and thought about every single aspect of the social media app Facebook that I would use. I listed them in the above section, *Using This App*. Next I thought about these from the perspective of a developer in regards to which gems and which programming concepts would assist me in implementing these features. 

#### Design

User
has_one :profile_picture
has_many :friendships
has_many :friendship_requests
has_many :posts
has_many :comments
has_many :notifications

#schema
t.string :username

---
#model ProfilePicture
belongs_to :user

#schema
t.belongs_to :user

---
#model Friendship
belongs_to :friendship_provider, class_name="User"
belongs_to :friendship_recipient, class_name="User"

#schema
t.belongs_to :friendship_provider
t.belongs_to :friendship_recipient

---
#model FriendshipRequest
belongs_to :request_provider, class_name="User"
belongs_to :request_recipient, class_name="User"

#schema
t.belongs_to :request_provider
t.belongs_to :request_recipient

---
#model Post
belongs_to :user
has_many :comments
has_many :likes, as: :liked_content

#schema
t.belongs_to :user
t.text :body

---
#model Comment
belongs_to :post
has_many :likes, as: :liked_content

#schema
t.belongs_to :post
t.text :body

---
#model Notification
belongs_to :user

#schema
t.belongs_to :user
t.boolean :notification_viewed

---
#model Like
belongs_to :liked_content, polymorphic: true

#schema
t.references :liked_content, polymorphic: true

---

#### Implementation

- View all friend posts in News Feed
- Deleting a post 
- Deleting a notification
- Creating a comment
- Creating notification if friend comments on a user profile
- Deleting a comment
- Creating a Post Liking and Comment Liking
- Creating notification if friend likes a user post or comment
- Deleting a Post Liking or Comment Liking

- Create end-to-end test that uses every feature in the app

- Implement profile pictures
- Implement OmniAuth for login
- Implement mailer
- Style using Tailwind
- Utilize Turbo to increase performance
- Deploy
- Populate with fake users
- Test with family members
