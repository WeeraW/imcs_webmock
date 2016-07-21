class CreateOrderOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :order_orders do |t|
      t.string :billing_id
      t.datetime :paid_full_date
      t.integer :create_by_staff_id
      t.integer :paid_approve_by_staff_id
      t.integer :shipping_approve_by_staff_id

      t.timestamps
    end
    add_index :order_orders, :create_by_staff_id
    add_index :order_orders, :paid_approve_by_staff_id
    add_index :order_orders, :shipping_approve_by_staff_id
    add_index :order_orders, :billing_id, unique: true

    add_foreign_key :order_orders, :staffs, column: :create_by_staff_id, name: :fk_rails_order_creator_staff

    add_foreign_key :order_orders, :staffs, column: :paid_approve_by_staff_id, name: :fk_rails_order_payment_approval_staff

    add_foreign_key :order_orders, :staffs, column: :shipping_approve_by_staff_id, name: :fk_rails_order_shipping_approval_staff
  end
end
