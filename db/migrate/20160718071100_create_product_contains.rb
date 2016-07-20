class CreateProductContains < ActiveRecord::Migration[5.0]
  def change
    create_table :product_contains do |t|
      t.belongs_to :inventory_inventory_item, foreign_key: true
      t.belongs_to :product_product, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
