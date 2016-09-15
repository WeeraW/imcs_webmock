class Staffs::Warehouses::InventoryMovementsReportsController < ApplicationController
  def inventory_movements
    @begin_date = DateTime.now.beginning_of_day
    @end_date = DateTime.now.end_of_day
    @inventory_movements = (Inventory::ItemLotStockOut.includes(inventory_item_lot: [:inventory_item], stock_out_history: [order_detail: [:order]]).where(created_at: @begin_date..@end_date) + Inventory::ItemLotStockIn.includes(inventory_item_lot: [:inventory_item]).where(created_at: @begin_date..@end_date)).sort_by { |e| e.created_at }
  end
end
