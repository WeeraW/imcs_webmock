class AddFreightTrackingCodeToFullfillmentShippingAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :fullfillment_shipping_addresses, :freight_tracking_code, :string
    add_index :fullfillment_shipping_addresses, :freight_tracking_code
  end
end
