class Warehouse::FacilityType < ApplicationRecord
  has_many :warehouse_facilities, class_name: 'Warehouse::Facility', foreign_key: 'warehouse_facility_type_id'

  validates :code,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { in: 2..30 },
            format: /\A([a-z]|_|[0-9]){1,}\z/i
  validates :display_name,
            presence: true,
            uniqueness: { case_sensitive: false }
end
