class Product::Contain < ApplicationRecord
  belongs_to :inventory_item, class_name: 'Inventory::InventoryItem', foreign_key: :inventory_inventory_item_id, optional: true
  belongs_to :product, class_name: 'Product::Product', foreign_key: :product_product_id, optional: true

  validates :quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 999
            }
end
