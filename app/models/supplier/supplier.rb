class Supplier::Supplier < ApplicationRecord
  has_many :contact_infos, class_name: 'Supplier::ContactInfo', foreign_key: 'supplier_supplier_id', dependent: :restrict_with_exception

  has_many :supply_inventory_items, class_name: 'Inventory::InventoryItem', foreign_key: 'supplier_supplier_id', dependent: :restrict_with_exception

  validates :company_code,
            :display_name,
            presence: true,
            length: { in: 2..150 }
  validates :company_code,
            :tax_id,
            uniqueness: { case_sensitive: false }
  validates :address,
            length: { in: 0..500, allow_blank: true }
  validates :postal_code,
            length: { allow_blank: true, is: 5 }
  validates :tax_id,
            length: { allow_blank: true, is: 13 }
end
