class AddFreightProviderToShippingAddress < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :fullfillment_shipping_addresses, :freight_provider, index: true, foreign_key: true
  end
end
