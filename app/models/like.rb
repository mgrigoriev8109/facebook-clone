# == Schema Information
#
# Table name: likes
#
#  id               :bigint           not null, primary key
#  liked_item_type  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  like_provider_id :bigint
#  liked_item_id    :bigint
#
# Indexes
#
#  index_likes_on_like_provider_id  (like_provider_id)
#  index_likes_on_liked_item        (liked_item_type,liked_item_id)
#
class Like < ApplicationRecord
  belongs_to :liked_item, polymorphic: true
  belongs_to :like_provider, class_name: "User"
  has_many :notifications, as: :notification_provider

  validates_uniqueness_of :like_provider_id, scope: :liked_item

  accepts_nested_attributes_for :notifications
end
