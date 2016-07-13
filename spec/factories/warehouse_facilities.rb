FactoryGirl.define do
  factory :warehouse_facility, class: 'Warehouse::Facility' do
    sequence(:code) { |n| "FACILITY#{n}" }
    sequence(:display_name) { |n| "Facility #{n}" }
    address 'TEST address'
    association :facility_type, factory: :warehouse_facility_type
  end
end
