class AddCountryRefToShippingAddress < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :fullfillment_shipping_addresses, :geo_country, index: true
  end
end
