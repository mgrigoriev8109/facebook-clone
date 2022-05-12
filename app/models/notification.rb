# == Schema Information
#
# Table name: notifications
#
#  id                         :bigint           not null, primary key
#  body                       :text
#  notification_provider_type :string
#  notification_viewed        :boolean          default(FALSE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  notification_provider_id   :bigint
#  recipient_id               :integer
#
# Indexes
#
#  index_notifications_on_notification_provider  (notification_provider_type,notification_provider_id)
#
class Notification < ApplicationRecord
  belongs_to :notification_provider, polymorphic: true

  def user_has_new_notifications
    notifications = Notification.all
    any_unviewed_notifications = false
    notifications.each do |notification|
      if notification.recipient_id == current_user.id && notification.notification_viewed == false
        any_unviewed_notifications = true
      end
    end
    any_unviewed_notifications
  end
end
