FactoryGirl.define do
  factory :accounting_bank_branch, class: 'Accounting::BankBranch' do
    sequence(:display_name) { |n| "Branch Test #{n}" }
    association :accounting_bank, factory: :accounting_bank
  end
end
