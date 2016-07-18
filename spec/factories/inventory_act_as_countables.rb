FactoryGirl.define do
  factory :inventory_act_as_countable, class: 'Inventory::ActAsCountable' do
    association :inventory_countable_unit, factory: :inventory_countable_unit

    factory :inventory_item_act_as_countable do
      association :countable, factory: :inventory_inventory_item
    end
  end
end
