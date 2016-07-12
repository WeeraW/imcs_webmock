class Supplier::ContactInfo < ApplicationRecord
  belongs_to :supplier, class_name: 'Supplier::Supplier', foreign_key: :supplier_supplier_id

  before_validation :set_default_contact_person

  validates :contact_person,
            presence: true,
            length: { in: 2..120 }
  validates :telephone_number,
            :fax_number,
            format: /\A[0-9]{9}\z/i
  validates :telephone_ext,
            :fax_ext,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :mobile_number,
            format: /\A[0-9]{10}\z/i

  private

  def set_default_contact_person
    self.contact_person = 'Company' unless contact_person.present?
  end
end
