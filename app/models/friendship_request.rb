class FriendshipRequest < ApplicationRecord
  belongs_to :request_provider, class_name: "User"
  belongs_to :request_recipient, class_name: "User"
end
