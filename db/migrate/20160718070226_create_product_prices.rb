class CreateProductPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :product_prices do |t|
      t.decimal :price_th, precision: 19, scale: 4, null: false
      t.belongs_to :product_product, foreign_key: true
      t.belongs_to :staff, foreign_key: true

      t.timestamps
    end
  end
end
