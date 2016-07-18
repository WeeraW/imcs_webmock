FactoryGirl.define do
  factory :supplier_supplier, class: 'Supplier::Supplier' do
    sequence(:company_code) { |n| "company#{n}" }
    sequence(:display_name) { |n| "company test #{n}" }
    sequence(:tax_id) { |n| '0' * (13 - n.to_s.length) + n.to_s }
    address 'Test Address'
    postal_code '12345'
  end
end
