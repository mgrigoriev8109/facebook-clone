# == Schema Information
#
# Table name: notifications
#
#  id                    :bigint           not null, primary key
#  body                  :text
#  notification_viewed   :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  friendship_request_id :bigint
#  recipient_id          :integer
#
# Indexes
#
#  index_notifications_on_friendship_request_id  (friendship_request_id)
#
class Notification < ApplicationRecord
  belongs_to :friendship_request
end
