class AddNameToScraps < ActiveRecord::Migration
  def change
    add_column :scraps, :name, :string, null: false, default: ''
  end
end
