class Inventory::ItemLotStockOut < ApplicationRecord
  belongs_to :inventory_item_lot, class_name: 'Inventory::ItemLot', foreign_key: :inventory_item_lot_id

  validates :quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 100_000_000
            }
end
