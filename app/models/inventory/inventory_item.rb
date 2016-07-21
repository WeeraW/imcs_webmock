class Inventory::InventoryItem < ApplicationRecord
  belongs_to :supplier, class_name: 'Supplier::Supplier', foreign_key: :supplier_supplier_id
  has_many :item_lots, class_name: 'Inventory::ItemLot', foreign_key: :inventory_inventory_item_id, dependent: :restrict_with_exception
  has_one :inventory_act_as_countable, class_name: 'Inventory::ActAsCountable', as: :countable
  has_one :inventory_countable_unit, through: :inventory_act_as_countable

  validates :display_name,
            presence: true

  def restock(lot_number, quantity, price = nil, mfg_date = nil, exp_date = nil)
    lot = item_lots.find_or_initialize_by(lot_number: lot_number)
    lot.tap do |l|
      l.mfg_date = mfg_date
      l.exp_date = exp_date
    end
    lot.save!
    add_item_to_lot(quantity, price)
  end

  private

  def add_item_to_lot(quantity, price)
    lot.instock_items.create! quantity: quantity, price_per_count: price
  end
end
