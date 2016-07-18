class CreateInventoryInventoryItems < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_inventory_items do |t|
      t.string :display_name, null: false
      t.string :supplier_sku
      t.belongs_to :supplier_supplier, foreign_key: true

      t.timestamps
    end

    add_index :inventory_inventory_items, [:supplier_sku, :supplier_supplier_id], name: :index_sku_by_supplier
  end
end
