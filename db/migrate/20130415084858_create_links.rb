class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.references :scrap
      t.references :user

      t.timestamps
    end
    add_index :links, :scrap_id
    add_index :links, :user_id
  end
end
