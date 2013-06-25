class CacheLinksCount < ActiveRecord::Migration
  def up
     execute "UPDATE scraps SET links_count=(SELECT COUNT(*) FROM links WHERE scrap_id = scraps.id)"
  end

  def down
  end
end
