class Fullfillment::ShippingAddress < ApplicationRecord
  has_many :act_as_shippingables, class_name: 'Fullfillment::ActAsShippingable', foreign_key: :fullfillment_shipping_address_id

  has_many :ship_by_orders, class_name: 'Order::Order', through: :act_as_shippingables, dependent: :restrict_with_exception
  validates :recipient_name,
            presence: true,
            length: {
              minimum: 4,
              maximum: 150
            }
  validates :recipient_telephone_number,
            length: {
              minimum: 9,
              allow_nil: true
            },
            numericality: { only_integer: true }
  validates :address,
            presence: true,
            length: {
              minimum: 3,
              maximum: 500
            }
  validates :district,
            presence: true,
            length: {
              minimum: 3,
              maximum: 150
            }
  validates :city,
            presence: true,
            length: {
              minimum: 3,
              maximum: 150
            }
  validates :state,
            presence: true,
            length: {
              minimum: 3,
              maximum: 150
            }
  validates :postal_code,
            presence: true,
            length: { is: 5 }
end
