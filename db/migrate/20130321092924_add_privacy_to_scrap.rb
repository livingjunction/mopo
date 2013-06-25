class AddPrivacyToScrap < ActiveRecord::Migration
  def change
    add_column :scraps, :privacy, :enum, :limit => [:public, :registered, :project, :private], :null => false
  end
end
