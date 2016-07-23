class Fullfillment::ActAsShippingable < ApplicationRecord
  belongs_to :fullfillment_shipping_address, class_name: 'Fullfillment::ShippingAddress', foreign_key: :fullfillment_shipping_address_id
  belongs_to :shippingable, polymorphic: true
end
