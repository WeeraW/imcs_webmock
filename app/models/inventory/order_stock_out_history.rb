class Inventory::OrderStockOutHistory < ApplicationRecord
  belongs_to :inventory_item_lot_stock_out, class_name: 'Inventory::ItemLotStockOut', foreign_key: :inventory_item_lot_stock_out_id
  belongs_to :order_detail, class_name: 'Order::Detail', foreign_key: :order_detail_id
end
