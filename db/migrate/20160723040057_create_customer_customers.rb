class CreateCustomerCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_customers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :nickname
      t.string :telephone_number
      t.string :mobile_number
      t.belongs_to :staff, foreign_key: true

      t.timestamps
    end
  end
end
