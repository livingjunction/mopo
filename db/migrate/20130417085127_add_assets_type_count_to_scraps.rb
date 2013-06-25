class AddAssetsTypeCountToScraps < ActiveRecord::Migration
  def change
    add_column :scraps, :images_count, :integer, default: 0, null: false
    add_column :scraps, :videos_count, :integer, default: 0, null: false
    add_column :scraps, :audios_count, :integer, default: 0, null: false
    add_column :scraps, :files_count, :integer, default: 0, null: false
  end
end
