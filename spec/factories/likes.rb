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
FactoryBot.define do
  factory :like do
    
  end
end
