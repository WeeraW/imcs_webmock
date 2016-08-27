FactoryGirl.define do
  factory :accounting_company_bank_account, class: 'Accounting::CompanyBankAccount' do
    sequence(:code) { |n| "#{'0' * (10 - n.to_s.length)}#{n}" }
    sequence(:display_name) { |n| "Compay Bank Account 1" }
    association :accounting_bank_branch, factory: :accounting_bank_branch
  end
end
