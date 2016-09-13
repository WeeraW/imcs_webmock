class Accounting::Bank < ApplicationRecord
  has_many :bank_branches, class_name: 'Accounting::BankBranch', foreign_key: :accounting_bank_id
  has_many :company_accounts, class_name: 'Accounting::CompanyBankAccount', through: :bank_branch

  validates :code,
            presence: true,
            uniqueness: { case_sensitive: :false }
  validates :display_name,
            presence: true
end
