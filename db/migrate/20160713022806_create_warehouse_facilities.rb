class CreateWarehouseFacilities < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouse_facilities do |t|
      t.string :code, null: false
      t.string :display_name, null: false
      t.text :address
      t.references :warehouse_facility_type, foreign_key: true

      t.timestamps
    end
    add_index :warehouse_facilities, :code, unique: true
  end
end
