class AddAccountingCompanyBankAccountToPaymentDetail < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :payment_details, :accounting_company_bank_account, null: false, foreign_key: true, index: true
  end
end
