require "base64"
# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  login                  :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  token                  :string
#  uid                    :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github]
  
  #has_many :friendships
  has_many :posts
  has_many :comments
  has_many :friendship_requests
  has_many :likes

  after_create_commit :generate_friendship_request
  
  def user_has_new_notifications
    notifications = Notification.all
    any_unviewed_notifications = false
    notifications.each do |notification|
      if notification.recipient_id == self.id && notification.notification_viewed == false
        any_unviewed_notifications = true
      end
    end
    any_unviewed_notifications
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.token = auth.credentials.token
      user.email = auth.info.email
      user.provider = auth.provider
      user.login = auth.extra.raw_info.login
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def get_recent_repo
    debugger
    if self.provider == "github"
      client = Octokit::Client.new(:access_token => self.token)
      user_repos = client.user.rels[:repos].get.data
      sorted_repos = user_repos.sort_by(&:created_at)
      newest_repo_id = sorted_repos.last.id
      client.readme newest_repo_id 
      encoded_repo_readme = client.readme newest_repo_id
      decoded_readme = Base64.decode64(encoded_repo_readme.content)
      readme_sentence = decoded_readme.split('.')[0]
      formatted_sentence = readme_sentence.delete!('#') 
      formatted_sentence.prepend("Let me know if you want to contribute to the most recent open-source project I created:")
    end
  end

  private
  def generate_friendship_request
    unless User.all.length == 1
      test_user = User.all.first
      test_user_request = FriendshipRequest.new(request_provider_id: test_user.id, request_recipient_id: self.id)
      test_user_request.save
    end
  end
end
