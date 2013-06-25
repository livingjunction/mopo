class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.belongs_to :user
      t.belongs_to :scrap
      t.column :color, :enum, :limit => [:green, :red, :yellow]

      t.timestamps
    end
    add_index :flags, :user_id
    add_index :flags, :scrap_id, :unique => true
  end
end
