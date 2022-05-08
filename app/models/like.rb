class Like < ApplicationRecord
  belongs_to :like_provider, polymorphic: true
  belongs_to :user
end
