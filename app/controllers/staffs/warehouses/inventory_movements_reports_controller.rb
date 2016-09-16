class Staffs::Warehouses::InventoryMovementsReportsController < ApplicationController
  def inventory_movements
    @begin_date = params[:begin_date].blank? ? Date.today.beginning_of_month : Date.parse(params[:begin_date])
    @end_date = params[:end_date].blank? ? Date.today.end_of_month : Date.parse(params[:end_date])
    @inventory_movements = (Inventory::ItemLotStockOut.includes(inventory_item_lot: [:inventory_item], stock_out_history: [order_detail: [:order]]).where(created_at: @begin_date..@end_date) + Inventory::ItemLotStockIn.includes(inventory_item_lot: [:inventory_item]).where(created_at: @begin_date..@end_date)).sort_by { |e| e.created_at }
  end
end
