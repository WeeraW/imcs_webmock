require 'active_support/concern'

module Shippingable
  extend ActiveSupport::Concern
  included do
    has_one :act_as_shippingable, class_name: 'Fullfillment::ActAsShippingable', as: :shippingable
    has_one :shipping_address, class_name: 'Fullfillment::ShippingAddress', through: :act_as_shippingable, source: :fullfillment_shipping_address, autosave: true
  end
end
