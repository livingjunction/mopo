class AddLinksCountToScraps < ActiveRecord::Migration
  def change
    add_column :scraps, :links_count, :integer, default: 0, null: false
  end
end
