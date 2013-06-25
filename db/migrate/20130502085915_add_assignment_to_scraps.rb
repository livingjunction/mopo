class AddAssignmentToScraps < ActiveRecord::Migration
  def up
    add_column :scraps, :assignment_id, :integer
    add_index :scraps, :assignment_id
    execute "UPDATE scraps SET assignment_id=(SELECT assignment_id FROM projects WHERE project_id = projects.id)"
  end
  
  def down
    remove_column :scraps, :assignment_id
  end
end
