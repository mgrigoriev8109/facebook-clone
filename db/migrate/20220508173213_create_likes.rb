class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|

      t.belongs_to :like_provider
      t.references :liked_item, polymorphic: true
      t.timestamps
    end
  end
end
