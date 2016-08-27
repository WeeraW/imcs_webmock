class CreateAccountingBanks < ActiveRecord::Migration[5.0]
  def change
    create_table :accounting_banks do |t|
      t.string :code
      t.string :display_name

      t.timestamps
    end
  end
end
