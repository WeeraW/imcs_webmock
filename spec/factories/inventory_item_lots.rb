FactoryGirl.define do
  factory :inventory_item_lot, class: 'Inventory::ItemLot' do
    sequence(:lot_number) { |n| "LOT-TEST-#{n}" }
    mfg_date 1.year.ago
    exp_date Date.today
    association :inventory_item, factory: :inventory_inventory_item
    association :store_at, factory: :warehouse_facility
  end
end
