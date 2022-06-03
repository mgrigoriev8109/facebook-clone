class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|

      t.timestamps
      t.belongs_to :friendship_provider
      t.belongs_to :friendship_recipient
    end
  end
end
