class Accounting::CompanyBankAccount < ApplicationRecord
  belongs_to :bank_branch, class_name: 'Accounting::BankBranch', foreign_key: :accounting_bank_branch_id
  has_one :bank, class_name: 'Accounting::Bank', through: :bank_branch

  validates :code,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :code,
            format: /\A[0-9]{10}\z/i,
            unless: Proc.new { |ac| ac.bank.code.eql?('GSB') || ac.bank.code.eql?('BACC') }
  validates :code,
            format: /\A[0-9]{12}\z/i,
            if: Proc.new { |ac| ac.bank.code.eql?('GSB') }
  validates :code,
            format: /\A[0-9]{13}\z/i, if: Proc.new { |ac| ac.bank.code.eql?('BACC') }
  validates :display_name,
            presence: true
end
