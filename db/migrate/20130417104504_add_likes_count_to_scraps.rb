class AddLikesCountToScraps < ActiveRecord::Migration
  def change
    add_column :scraps, :likes_count, :integer, default: 0, null: false
  end
end
