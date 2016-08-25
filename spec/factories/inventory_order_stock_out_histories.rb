FactoryGirl.define do
  factory :inventory_order_stock_out_history, class: 'Inventory::OrderStockOutHistory' do
    inventory_item_lot_stock_out nil
    order_detail nil
  end
end
