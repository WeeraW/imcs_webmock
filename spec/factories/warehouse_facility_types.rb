FactoryGirl.define do
  factory :warehouse_facility_type, class: 'Warehouse::FacilityType' do
    sequence(:code) { |n| "FACILITYT#{n}" }
    sequence(:display_name) { |n| "Facility Type #{n}" }
  end

  factory :default_facility_type, class: 'Warehouse::FacilityType' do
    id 0
    code 'UNIDENTIFIED'
    display_name 'Cannot Identified'
  end
end
