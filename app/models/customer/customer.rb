class Customer::Customer < ApplicationRecord
  belongs_to :create_by, class_name: 'Staff', foreign_key: :staff_id
  has_many :addressable, class_name: 'Fullfillment::ActAsShippingable', as: :shippingable, dependent: :restrict_with_exception
  has_many :addresses, class_name: 'Fullfillment::ShippingAddress', dependent: :restrict_with_exception, through: :addressable

  validates :first_name,
            presence: true,
            length: {
              minimum: 2,
              maximum: 150
            }
  validates :last_name,
            presence: true,
            length: {
              minimum: 2,
              maximum: 150
            }
  validates :nickname,
            presence: true,
            length: {
              minimum: 2,
              maximum: 30
            }
  validates :telephone_number,
            format: /\A[0-9]{9}\z/i
  validates :mobile_number,
            format: /\A[0-9]{10}\z/i
end
