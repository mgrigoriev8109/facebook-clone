class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|

      t.belongs_to :user
      t.boolean :notification_viewed
      t.text :body

      t.timestamps
    end
  end
end
