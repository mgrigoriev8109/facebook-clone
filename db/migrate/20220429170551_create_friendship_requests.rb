class CreateFriendshipRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friendship_requests do |t|
      t.belongs_to :request_provider
      t.belongs_to :request_recipient
      
      t.timestamps
    end
  end
end
