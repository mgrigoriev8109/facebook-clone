class FriendshipRequest < ApplicationRecord
  belongs_to :request_provider, class_name: "User"
  belongs_to :request_recipient, class_name: "User"

  validates_uniqueness_of :request_provider_id, scope: :request_recipient_id

end
