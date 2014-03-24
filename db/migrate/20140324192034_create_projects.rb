class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.column :name, :string
      t.column :employee_name, :string
      t.timestamps
    end

    add_column :employees, :project, :string
  end
end
