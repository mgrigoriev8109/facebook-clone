# == Schema Information
#
# Table name: friendship_requests
#
#  id                   :bigint           not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  request_provider_id  :bigint
#  request_recipient_id :bigint
#
# Indexes
#
#  index_friendship_requests_on_request_provider_id   (request_provider_id)
#  index_friendship_requests_on_request_recipient_id  (request_recipient_id)
#
class FriendshipRequest < ApplicationRecord
  belongs_to :request_provider, class_name: "User"
  belongs_to :request_recipient, class_name: "User"

  validates_uniqueness_of :request_provider_id, scope: :request_recipient_id

end
