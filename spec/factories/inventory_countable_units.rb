FactoryGirl.define do
  factory :inventory_countable_unit, class: 'Inventory::CountableUnit' do
    sequence(:code) { |n| "COUNT#{n}" }
    sequence(:display_name) { |n| "COUNT UNIT #{n}" }
  end
end
