class CreateSupplierSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :supplier_suppliers do |t|
      t.string :company_code
      t.string :display_name
      t.string :tax_id
      t.text :address
      t.string :postal_code

      t.timestamps
    end
  end
end
