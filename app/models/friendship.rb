# == Schema Information
#
# Table name: friendships
#
#  id                      :bigint           not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  friendship_provider_id  :bigint
#  friendship_recipient_id :bigint
#
# Indexes
#
#  index_friendships_on_friendship_provider_id   (friendship_provider_id)
#  index_friendships_on_friendship_recipient_id  (friendship_recipient_id)
#
class Friendship < ApplicationRecord
  belongs_to :friendship_provider, class_name: "User"
  belongs_to :friendship_recipient, class_name: "User"


  validates_uniqueness_of :friendship_provider_id, scope: :friendship_recipient_id

end
