class AddSaleableFlagToProductProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :product_products, :saleable, :boolean, default: false
  end
end
