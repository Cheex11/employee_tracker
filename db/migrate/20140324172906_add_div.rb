class AddDiv < ActiveRecord::Migration
  def change
      add_column :employees, :division, :string
  end
end
