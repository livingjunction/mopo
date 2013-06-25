class CacheLikesCount < ActiveRecord::Migration
  def up
    execute "UPDATE scraps SET likes_count=(SELECT COUNT(*) FROM likes WHERE scrap_id = scraps.id)"
  end

  def down
  end
end
