class AddStaffCreatatorToDistributor < ActiveRecord::Migration[5.0]
  def change
    add_column :distributors, :staff_creator_id, :integer, foreign_key: true
    add_foreign_key :distributors, :staffs, column: :staff_creator_id
    add_index :distributors, [:id, :staff_creator_id], unique: true, name: :index_distributor_staff_creator
  end
end
