class AddTransferFromBankToPaymentDetails < ActiveRecord::Migration[5.0]
  def change
    # add_column :payment_details, :transfer_from_bank_id, :integer
    add_reference :payment_details, :from_bank, foreign_key: { to_table: :accounting_banks }, index: { name: 'index_from_bank_id_on_payment_datails' }
  end
end
