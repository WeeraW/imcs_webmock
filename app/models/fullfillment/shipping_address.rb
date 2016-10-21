class Fullfillment::ShippingAddress < ApplicationRecord
  belongs_to :freight_provider, class_name: 'Freight::Provider', foreign_key: :freight_provider_id, optional: true
  belongs_to :ship_to_country, class_name: 'Geo::Country', foreign_key: :geo_country_id, optional: true

  has_many :act_as_shippingables, class_name: 'Fullfillment::ActAsShippingable', foreign_key: :fullfillment_shipping_address_id

  has_many :ship_by_orders, class_name: 'Order::Order', through: :act_as_shippingables, dependent: :restrict_with_exception

  validates :freight_tracking_code,
            length: {
              in: 5..40,
              allow_blank: true
            }
  validates :recipient_name,
            presence: true,
            length: {
              minimum: 4,
              maximum: 150
            }
  validates :recipient_telephone_number,
            format: {
              with: /\A(\+|\-)?[0-9]{9,}\z/,
              allow_blank: true
            }
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
