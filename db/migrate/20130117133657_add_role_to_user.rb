class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :enum, :limit => [:student, :teacher], :null => false
  end
end
