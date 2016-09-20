class AddSaleByStaffIdToOrderOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :order_orders, :sale_by_staff_id, :integer
    add_foreign_key :order_orders, :staffs, column: :sale_by_staff_id
    add_index :order_orders, :sale_by_staff_id
  end
end
