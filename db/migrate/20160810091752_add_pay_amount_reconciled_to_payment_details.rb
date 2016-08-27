class AddPayAmountReconciledToPaymentDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_details, :pay_amount_reconciled, :decimal, precision: 14, scale: 4
  end
end
