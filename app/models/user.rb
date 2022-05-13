# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
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
         :recoverable, :rememberable, :validatable
  
  #has_many :friendships
  has_many :posts
  has_many :comments
  has_many :friendship_requests
  has_many :likes

  devise :omniauthable, omniauth_providers: %i[github]
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
end
