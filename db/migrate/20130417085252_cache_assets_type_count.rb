class CacheAssetsTypeCount < ActiveRecord::Migration
  def up
    execute "UPDATE scraps SET 
      images_count=(SELECT COUNT(*) FROM assets WHERE scrap_id = scraps.id AND TYPE='Scrap::Image'),
      videos_count=(SELECT COUNT(*) FROM assets WHERE scrap_id = scraps.id AND TYPE='Scrap::Video'),
      audios_count=(SELECT COUNT(*) FROM assets WHERE scrap_id = scraps.id AND TYPE='Scrap::Audio'),
      files_count=(SELECT COUNT(*) FROM assets WHERE scrap_id = scraps.id AND TYPE='Scrap::File')"
  end

  def down
  end
end
