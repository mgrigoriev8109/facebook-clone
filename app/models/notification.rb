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
end
