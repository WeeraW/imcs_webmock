class CreateFullfillmentShippingAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :fullfillment_shipping_addresses do |t|
      t.string :recipient_name
      t.string :recipient_telephone_number
      t.text :address
      t.string :district
      t.string :city
      t.string :state
      t.string :postal_code

      t.timestamps
    end
  end
end
