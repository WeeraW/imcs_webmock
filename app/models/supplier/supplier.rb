class Supplier::Supplier < ApplicationRecord
  has_many :contact_infos, class_name: 'Supplier::ContactInfo', foreign_key: 'supplier_supplier_id', dependent: :restrict_with_exception

  validates :company_code,
            :display_name,
            presence: true,
            length: { in: 2..150 }
  validates :company_code,
            :tax_id,
            uniqueness: { case_sensitive: false }
  validates :address,
            length: { in: 0..500 }
  validates :postal_code,
            length: { is: 5 }
  validates :tax_id,
            length: { is: 13 }
end
