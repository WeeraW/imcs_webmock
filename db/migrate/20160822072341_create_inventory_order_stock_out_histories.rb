class CreateInventoryOrderStockOutHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_order_stock_out_histories do |t|
      t.belongs_to :inventory_item_lot_stock_out, foreign_key: true, index: { name: 'index_stock_out_on_inventory_stock_out_histories' }
      t.belongs_to :order_detail, foreign_key: true, index: { name: 'index_order_detail_on_inventory_stock_out_histories' }

      t.timestamps
    end
  end
end
