class CreateInventoryActAsCountables < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_act_as_countables do |t|
      t.integer :countable_id
      t.string :countable_type
      t.integer :inventory_countable_unit_id

      t.timestamps
    end
    add_index :inventory_act_as_countables, [:countable_id, :countable_type, :inventory_countable_unit_id], name: :index_countable_unit_type_on_act_as_countable
    add_foreign_key :inventory_act_as_countables, :inventory_countable_units
  end
end
