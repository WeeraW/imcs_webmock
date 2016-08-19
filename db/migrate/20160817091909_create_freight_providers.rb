class CreateFreightProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :freight_providers do |t|
      t.string :name
      t.string :telephone_number
      t.string :fax_number

      t.timestamps
    end
  end
end
