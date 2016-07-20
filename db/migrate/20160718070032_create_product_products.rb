class CreateProductProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :product_products do |t|
      t.string :sku, null: false
      t.string :name_th, null: false
      t.string :name_en, null: false
      t.text :description_th
      t.text :description_en
      t.string :slug, null: false
      t.belongs_to :staff, foreign_key: true

      t.timestamps
      t.index :sku, unique: true, name: :index_product_by_sku
      t.index :slug, unique: true, name: :index_product_by_slug
      t.index [:id, :staff_id], name: :index_product_by_id_staff_id
    end
  end
end
