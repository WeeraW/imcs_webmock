class CreateFullfillmentActAsShippingables < ActiveRecord::Migration[5.0]
  def change
    create_table :fullfillment_act_as_shippingables do |t|
      t.integer :fullfillment_shipping_address_id
      t.integer :shippingable_id
      t.string :shippingable_type

      t.timestamps
    end
    add_index :fullfillment_act_as_shippingables, :fullfillment_shipping_address_id, name:  :index_fullfillment_shipping_address_id_on_act_as_shippingables
    add_index :fullfillment_act_as_shippingables, [:shippingable_id, :shippingable_type], name:  :index_shippingable_on_act_as_shippingables

    add_foreign_key :fullfillment_act_as_shippingables, :fullfillment_shipping_addresses, column: :fullfillment_shipping_address_id, name: :fk_rails_act_as_shippingables_shipping_address
  end
end
