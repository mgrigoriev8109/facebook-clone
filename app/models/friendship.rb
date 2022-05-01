class Friendship < ApplicationRecord
  belongs_to :friendship_provider, class_name: "User"
  belongs_to :friendship_recipient, class_name: "User"
end
