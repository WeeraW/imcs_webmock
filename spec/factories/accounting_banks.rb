FactoryGirl.define do
  factory :accounting_bank, class: 'Accounting::Bank' do
    sequence(:code) { |n| "Bank-Code-#{n}" }
    sequence(:display_name) { |n| "Bank #{n}" }
  end
end
