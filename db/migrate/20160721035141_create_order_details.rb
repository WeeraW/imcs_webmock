class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.decimal :price_per_count, precision: 19, scale: 4
      t.belongs_to :product_product, foreign_key: true
      t.belongs_to :order_order, foreign_key: true

      t.timestamps
    end
  end
end
