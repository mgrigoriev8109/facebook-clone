class Like < ApplicationRecord
  belongs_to :liked_item, polymorphic: true
  belongs_to :like_provider, class_name: "User"

  accepts_nested_attributes_for :notifications
end
