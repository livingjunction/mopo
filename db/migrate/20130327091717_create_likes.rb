class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.references :scrap

      t.timestamps
    end
    
    add_index :likes, [:user_id, :scrap_id], :unique => true
  end
end
