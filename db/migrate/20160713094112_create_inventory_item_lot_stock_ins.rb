class CreateInventoryItemLotStockIns < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_item_lot_stock_ins do |t|
      t.integer :quantity, null: false
      t.belongs_to :inventory_item_lot, foreign_key: true
      t.decimal :price_per_count, scale: 4, precision: 19

      t.timestamps
    end
  end
end
