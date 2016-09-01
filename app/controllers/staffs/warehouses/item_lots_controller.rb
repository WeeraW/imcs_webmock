class Staffs::Warehouses::ItemLotsController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_inventory_item!
  def index
    @item_lots = @inventory_item.item_lots
  end

  def new
    @item_lot = @inventory_item.item_lots.new
  end

  def create
    @item_lot = @inventory_item.item_lots.find_or_initialize_by(lot_number: item_lot_params[:lot_number])
    add_attr_if_item_lot_is_new_record
    add_stock_in_if_item_lot_is_old_record
    render_or_redirect_to_index_after_save
  end

  private

  def render_or_redirect_to_index_after_save
    if @item_lot.save
      respond_to do |format|
        format.html { redirect_to staffs_warehouses_inventory_item_lots_path }
      end
    else
      render 'new'
    end
  end

  def add_attr_if_item_lot_is_new_record
    return unless @item_lot.new_record?
    @item_lot.tap do |attribute|
      attribute.lot_number = item_lot_params[:lot_number]
      attribute.mfg_date = item_lot_params[:mfg_date]
      attribute.exp_date = item_lot_params[:exp_date]
    end
    add_instock_item
  end

  def add_stock_in_if_item_lot_is_old_record
    return unless @item_lot.persisted?
    @item_lot.instock_items.new(instock_items_params)
  end

  def find_inventory_item!
    @inventory_item = Inventory::InventoryItem.find(params[:inventory_id])
  end

  def instock_items_params
    params.require(:instock_items).permit(:quantity, :price_per_count)
  end

  def item_lot_params
    params.require(:inventory_item_lot).permit(:lot_number, :mfg_date, :exp_date, instock_items_attributes: [:id, :quantity, :price_per_count])
  end

  def add_instock_item
    @item_lot.instock_items.new do |o|
      o.quantity = instock_items_params[:quantity]
      o.price_per_count = instock_items_params[:price_per_count]
    end
  end
end
