class CreatePaymentDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_details do |t|
      t.integer :status, default: 0
      t.decimal :pay_amount, precision: 19, scale: 4
      t.datetime :pay_datetime, null: false
      t.text :note
      t.belongs_to :order_order, foreign_key: true
      t.integer :approve_by_staff_id
      t.integer :create_by_staff_id

      t.timestamps
    end
    add_foreign_key :payment_details, :staffs, column: :create_by_staff_id, name: :fk_rails_payment_details_creator_staff

    add_foreign_key :payment_details, :staffs, column: :approve_by_staff_id, name: :fk_rails_payment_details_approval_staff
  end
end
