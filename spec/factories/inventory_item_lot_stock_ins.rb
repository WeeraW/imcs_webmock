FactoryGirl.define do
  factory :inventory_item_lot_stock_in, class: 'Inventory::ItemLotStockIn' do
    quantity 10
    price_per_count 10.0
    inventory_item_lot
  end
end
