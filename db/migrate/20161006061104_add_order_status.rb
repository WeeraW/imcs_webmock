class AddOrderStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :order_orders, :status, :integer, default: 0
  end
end
