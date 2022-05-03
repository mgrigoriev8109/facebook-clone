# == Schema Information
#
# Table name: notifications
#
#  id                  :bigint           not null, primary key
#  body                :text
#  notification_viewed :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Notification < ApplicationRecord
  belongs_to :friendship_request
end
