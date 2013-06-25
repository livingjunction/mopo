class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :category
      t.references :user
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :assignments, :category_id
    add_index :assignments, :user_id
  end
end
