FactoryGirl.define do
  factory :inventory_item_lot_stock_out, class: 'Inventory::ItemLotStockOut' do
    quantity 1
    inventory_item_lot nil
  end
end
