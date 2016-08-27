class CreateAccountingCompanyBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounting_company_bank_accounts do |t|
      t.string :code
      t.string :display_name
      t.integer :accounting_bank_branch_id, foreign_key: true

      t.timestamps
    end
    add_index :accounting_company_bank_accounts, :accounting_bank_branch_id, name: :index_bank_branch_on_company_accounts
  end
end
