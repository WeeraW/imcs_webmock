class AddStaffCreatatorToDistributor < ActiveRecord::Migration[5.0]
  def change
    add_reference :distributors, :staffs, index: true, foreign_key: true
  end
end
