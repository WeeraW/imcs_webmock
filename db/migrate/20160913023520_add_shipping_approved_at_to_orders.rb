class AddShippingApprovedAtToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :order_orders, :shipping_approved_at, :datetime
  end
end
