class Accounting::BankBranch < ApplicationRecord
  belongs_to :bank, class_name: 'Accounting::Bank', foreign_key: :accounting_bank_id
  has_many :company_accounts, class_name: 'Accounting::CompanyBankAccount', foreign_key: :accounting_company_bank_account_id
  validates :display_name,
            presence: true
end
