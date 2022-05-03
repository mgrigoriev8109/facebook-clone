class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|

      t.boolean :notification_viewed, :default => false
      t.text :body

      t.timestamps
    end
  end
end
