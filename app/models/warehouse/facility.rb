class Warehouse::Facility < ApplicationRecord
  belongs_to :facility_type, class_name: 'Warehouse::FacilityType', foreign_key: :warehouse_facility_type_id

  before_validation :set_default_facility_type

  validates :code,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { in: 2..30 },
            format: /\A([a-z]|_|[0-9]){1,}\z/i
  validates :display_name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :address,
            length: { maximum: 500 }

  private

  def set_default_facility_type
    self.warehouse_facility_type_id = 0 unless warehouse_facility_type_id.present?
  end
end
