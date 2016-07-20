class Product::Contain < ApplicationRecord
  belongs_to :inventory_item, class_name: 'Inventory::InventoryItem', foreign_key: :inventoy_inventory_item_id
  belongs_to :product, class_name: 'Product::Product', foreign_key: :product_product_id
  validates :quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 999
            }

end
