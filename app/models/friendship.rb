class Friendship < ApplicationRecord
  belongs_to :friendship_provider, class_name: "User"
  belongs_to :friendship_recipient, class_name: "User"


  validates_uniqueness_of :friendship_provider_id, scope: :friendship_recipient_id

end
