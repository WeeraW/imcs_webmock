class AddIsActiveToStaffs < ActiveRecord::Migration[5.0]
  def change
    add_column :staffs, :is_active, :boolean, default: false
  end
end
