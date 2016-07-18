class CreateInventoryCountableUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_countable_units do |t|
      t.string :code
      t.string :display_name

      t.timestamps
    end
  end
end
