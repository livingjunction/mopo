class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :activity
      t.belongs_to :user
      t.boolean :is_read, default: false

      t.timestamps
    end
    add_index :notifications, :activity_id
    add_index :notifications, :user_id
  end
end
