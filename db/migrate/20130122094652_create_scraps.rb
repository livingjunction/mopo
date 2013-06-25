class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.references :project
      t.text :description

      t.timestamps
    end
    add_index :scraps, :project_id
  end
end
