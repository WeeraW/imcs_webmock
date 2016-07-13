class CreateWarehouseFacilityTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouse_facility_types do |t|
      t.string :code, null: false
      t.string :display_name, null: false

      t.timestamps
    end
    add_index :warehouse_facility_types, :code, unique: true
  end
end
