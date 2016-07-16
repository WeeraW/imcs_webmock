FactoryGirl.define do
  factory :inventory_inventory_item, class: 'Inventory::InventoryItem' do
    sequence(:display_name) { |n| "Inventory Item #{n}" }
    sequence(:supplier_sku) { |n| "SKUTEST-#{n}" }
    association :supplier, factory: :supplier_supplier
  end
end
