class AddCanceledAtToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :order_orders, :canceled_at, :datetime
  end
end
