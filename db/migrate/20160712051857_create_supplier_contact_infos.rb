class CreateSupplierContactInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :supplier_contact_infos do |t|
      t.string :contact_person
      t.string :telephone_number
      t.string :telephone_ext
      t.string :mobile_number
      t.string :fax_number
      t.string :fax_ext
      t.belongs_to :supplier_supplier, foreign_key: true

      t.timestamps
    end
  end
end
