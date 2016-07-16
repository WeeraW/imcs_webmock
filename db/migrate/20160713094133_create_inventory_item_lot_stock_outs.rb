class CreateInventoryItemLotStockOuts < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_item_lot_stock_outs do |t|
      t.integer :quantity, null: false
      t.belongs_to :inventory_item_lot, foreign_key: true

      t.timestamps
    end
  end
end
