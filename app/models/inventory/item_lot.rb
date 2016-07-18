class Inventory::ItemLot < ApplicationRecord
  belongs_to :inventory_item, class_name: 'Inventory::InventoryItem', foreign_key: :inventory_inventory_item_id
  belongs_to :store_at, class_name: 'Warehouse::Facility', foreign_key: :warehouse_facility_id
  has_many :instock_items, class_name: 'Inventory::ItemLotStockIn', foreign_key: 'inventory_item_lot_id'
  has_many :outstock_items, class_name: 'Inventory::ItemLotStockOut', foreign_key: 'inventory_item_lot_id'

  before_validation :set_default_stock_location

  validates :lot_number,
            presence: true
  validates :mfg_date,
            presence: true
  validates :exp_date,
            presence: true
  validate :exp_date_greater_than_mfg_date
  validate :mfg_date_lesser_than_exp_date

  def available
    total_instock - total_outstock
  end

  def avg_cost_price
    if instock_items.specified_price_per_count.any?
      total_cost_price / instock_items.specified_price_per_count.count
    else
      0
    end
  end

  def total_instock
    instock_items.sum :quantity
  end

  def total_outstock
    outstock_items.sum :quantity
  end

  def total_cost_price
    instock_items.specified_price_per_count.sum :price_per_count
  end

  private

  def mfg_date_lesser_than_exp_date
    if mfg_date.present?
      errors.add(:mfg_date, 'must lesser than expiring date.') if (exp_date <=> mfg_date).eql?(-1)
    end
  end

  def exp_date_greater_than_mfg_date
    if exp_date.present?
      errors.add(:exp_date, 'must greater than manufactoring date.') if (exp_date <=> mfg_date).eql?(-1)
    end
  end

  def set_default_stock_location
    self.warehouse_facility_id = 0 if store_at.nil?
  end
end
