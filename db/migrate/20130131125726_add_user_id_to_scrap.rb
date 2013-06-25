class AddUserIdToScrap < ActiveRecord::Migration
  def change
    add_column :scraps, :user_id, :integer
    add_index :scraps, :user_id
  end
end
