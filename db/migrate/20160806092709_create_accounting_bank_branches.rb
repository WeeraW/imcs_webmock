class CreateAccountingBankBranches < ActiveRecord::Migration[5.0]
  def change
    create_table :accounting_bank_branches do |t|
      t.string :display_name
      t.belongs_to :accounting_bank

      t.timestamps
    end
  end
end
