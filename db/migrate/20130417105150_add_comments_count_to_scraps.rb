class AddCommentsCountToScraps < ActiveRecord::Migration
  def change
    add_column :scraps, :comments_count, :integer, default: 0, null: false
  end
end
