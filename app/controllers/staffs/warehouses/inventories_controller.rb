class Staffs::Warehouses::InventoriesController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_inventory_item!, only: [:show, :edit, :update]
  def index
    @inventory_items = Inventory::InventoryItem.all
  end

  def show
  end

  def new
    @inventory_item = Inventory::InventoryItem.new
  end

  def create
    @inventory_item = Inventory::InventoryItem.new(inventory_item_params)
    render_or_redirect_to_index_after_save
  end

  def update
  end

  def destroy
  end

  private

  def find_inventory_item!
    @inventory_item = Inventory::InventoryItem.find(params[:id])
  end

  def inventory_item_params
    params.require(:inventory_inventory_item).permit(:supplier_sku, :display_name, :supplier_supplier_id)
  end

  def render_or_redirect_to_index_after_save
    if @inventory_item.save!
      redirect_to staffs_warehouses_inventories_path
    else
      render 'new'
    end
  end
end
