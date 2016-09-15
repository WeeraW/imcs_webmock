class Inventory::ItemLotStockIn < ApplicationRecord
  belongs_to :inventory_item_lot, class_name: 'Inventory::ItemLot', foreign_key: :inventory_item_lot_id, optional: true

  scope :specified_price_per_count, -> { where ['price_per_count > ?', 0] }

  validates :quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 100_000_000
            }

  validates :price_per_count,
            allow_blank: true,
            numericality: {
              greater_than_or_equal_to: 0.0000,
              less_than_or_equal_to: 100_000_000.0000
            }
end
