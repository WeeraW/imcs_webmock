FactoryGirl.define do
  factory :customer_customer, class: 'Customer::Customer' do
    sequence(:first_name) { |n| "Test User #{n}" }
    sequence(:last_name) { |n| "Test#{n}" }
    sequence(:nickname) { |n| "Nick#{n}" }
    telephone_number '012345678'
    mobile_number '0123456789'
    association :create_by, factory: :staff
    association :addresses, factory: :fullfillment_shipping_address
  end
end
