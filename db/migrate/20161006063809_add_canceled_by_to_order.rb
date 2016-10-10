class AddCanceledByToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :order_orders, :canceled_by_staff_id, :integer
    add_index :order_orders, :canceled_by_staff_id
    add_foreign_key :order_orders, :staffs, column: :canceled_by_staff_id
  end
end
