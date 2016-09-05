class Staffs::Warehouses::InventoryMovementsController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_orders!

  # TODO: Need to refactoring inventory allocation processes
  # because it it will cause over inventory allocation bug in someday.
  # We need to set some "acceptable on hand quantity?" to reduce this risk?
  def create
    flash['warning'] = []
    @succeed_allocate_order_ids = []
    @orders.each do |order|
      next unless order.shipping_approve_by.nil?
      allocated_item_lots_by_order_detail = inventory_allocate(order)
      if allocated_item_lots_by_order_detail
        @succeed_allocate_order_ids.append(order.id)
        shipping_approve!(order)
        save_stock_out_and_stock_out_history!(allocated_item_lots_by_order_detail)
      else
        flash['warning'].append("Inventory Items in storage is not enough for Billng ID: #{order.billing_id}")
      end
    end
    redirect_to_render_order_receipt
  end

  private

  def save_stock_out_and_stock_out_history!(allocated_item_lots_by_order_detail)
    allocated_item_lots_by_order_detail.each_pair do |order_detail_id, stock_out_instances|
      stock_out_instances.each do |stock_out_instance|
        stock_out_instance.save!
        Inventory::OrderStockOutHistory.create!(order_detail_id: order_detail_id, inventory_item_lot_stock_out: stock_out_instance)
      end
    end
  end

  def shipping_approve!(order)
    order.shipping_approve_by = current_staff
    order.save!
  end

  def inventory_allocate(order)
    order_stock_out = {}
    order.order_details.each do |order_detail|
      order_stock_out[order_detail.id] = []
      allocate_inventory_lots = []
      order_detail.product.contains.each do |product_contain|
        allocate_inventory_lots.concat allocate_lot_by_inventory_item(product_contain, order_detail.quantity * product_contain.quantity)
      end
      return false unless allocate_inventory_lots
      order_stock_out[order_detail.id].concat allocate_inventory_lots
    end
    order_stock_out
  end

  def allocate_lot_by_inventory_item(product_contain, inventory_allocate_quantity)
    return false if inventory_allocate_quantity > product_contain.inventory_item.available
    allocated_lots = []
    inventory_item = Inventory::InventoryItem.find(product_contain.inventory_item.id)
    inventory_item.available_lots.each do |lot|
      if lot.available > inventory_allocate_quantity
        allocated_lots.append buld_allocate_lot(lot, inventory_allocate_quantity)
        break
      else
        inventory_allocate_quantity -= lot.available
        allocated_lots.append buld_allocate_lot(lot, lot.available)
      end
    end
    allocated_lots
  end

  def buld_allocate_lot(lot, allocate_quantity)
    outstock_item = lot.outstock_items.new(quantity: allocate_quantity)
    outstock_item
  end

  def redirect_to_render_order_receipt
    redirect_to controller: 'pdf_renders', action: 'stock_receipts', order_ids: @succeed_allocate_order_ids
  end

  def find_orders!
    @orders = Order::Order.includes(order_details: :product).where(id: params[:order_ids])
  end
end
