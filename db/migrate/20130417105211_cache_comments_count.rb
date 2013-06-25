class CacheCommentsCount < ActiveRecord::Migration
  def up
    execute "UPDATE scraps SET comments_count=(SELECT COUNT(*) FROM comments WHERE scrap_id = scraps.id)"
  end

  def down
  end
end
