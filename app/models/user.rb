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
      user.email = auth.info.email
      #user.provider = auth.provider
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
    client = Octokit::Client.new
    user = client.user 'mgrigoriev8109'
    repos = user.rels[:repos].get.data
    repos.sort_by(&:created_at)
    repos.first
  end
end
