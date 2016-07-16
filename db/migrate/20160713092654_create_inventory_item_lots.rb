class CreateInventoryItemLots < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_item_lots do |t|
      t.string :lot_number
      t.date :mfg_date
      t.date :exp_date
      t.references :inventory_inventory_item, foreign_key: true
      t.belongs_to :warehouse_facility, foreign_key: true

      t.timestamps
    end
  end
end
