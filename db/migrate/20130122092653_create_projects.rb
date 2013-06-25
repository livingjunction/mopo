class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :assignment
      t.string :name

      t.timestamps
    end
    add_index :projects, :assignment_id
  end
end
