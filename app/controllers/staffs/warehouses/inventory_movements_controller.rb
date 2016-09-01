class Staffs::Warehouses::InventoryMovementsController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_orders!

  # TODO: Need to refactoring inventory allocation processes
  # because it it will cause over inventory allocation bug in someday.
  # We need to set some "acceptable on hand quantity?" to reduce this risk?
  def create
    flash['warning'] = []
    @succeed_allocate_order_ids = []
    @orders_allocate_hash = {}
    @orders.each do |order|
      next unless order.shipping_approve_by.nil?
      order_detail_inventory_hash = generate_inventory_allocate_hash(order)
      if order_detail_inventory_hash
        @orders_allocate_hash.store(order.id, order_detail_inventory_hash)
        @succeed_allocate_order_ids.append(order.id)
        shipping_approve!(order)
      else
        flash['warning'].append("Inventory Items in storage is not enough for Billng ID: #{order.billing_id}")
      end
    end
    logger.info "Order Inventory Allocate Hash: #{@orders_allocate_hash.inspect}"
    allocate_inventory_orders
    redirect_to_render_order_receipt
  end

  private

  def shipping_approve!(order)
    order.shipping_approve_by = current_staff
    order.save!
  end

  # TODO: Need to refactoring!!
  # hash format { <order detail id> => { <inventory item id> => <quantity>, ... }, ... }
  def generate_inventory_allocate_hash(order)
    order_details_allocate_hash = {}
    order.order_details.each do |order_detail|
      allocate_hash = {}
      order_detail.product.contains.each do |product_contain|
        allocate_hash = generate_inventory_intem_and_quantity_hash(product_contain, order_detail.quantity * product_contain.quantity)
      end
      return false unless allocate_hash
      order_details_allocate_hash.store(order_detail.id, allocate_hash)
    end
    order_details_allocate_hash
  end

  def generate_inventory_intem_and_quantity_hash(product_contain, inventory_allocate_quantity)
    return false if inventory_allocate_quantity > product_contain.inventory_item.available
    inventory_allocate_hash = {}
    inventory_allocate_hash.store(product_contain.inventory_item.id, inventory_allocate_quantity)
    inventory_allocate_hash
  end

  def allocate_inventory_orders
    @orders_allocate_hash.each_value do |order_detail_hash|
      allocate_inventory(order_detail_hash)
    end
  end

  # TODO: Need to refactoring!!
  def allocate_inventory(order_detail_hash)
    order_detail_hash.each_pair do |order_detail_id, inventory_item_allocate_hash|
      inventory_item_allocate_hash.each_pair do |inventory_item_id, allocate_quantity|
        inventory_item = Inventory::InventoryItem.find(inventory_item_id)
        inventory_item.available_lots.each do |lot|
          if lot.available > allocate_quantity
            allocate_lot(lot, order_detail_id, allocate_quantity)
            break
          else
            allocate_quantity -= lot.available
            allocate_lot(lot, order_detail_id, lot.available)
          end
        end
      end
    end
  end

  def allocate_lot(lot, order_detail_id, allocate_quantity)
    outstock_item = lot.outstock_items.create!(quantity: allocate_quantity)
    Inventory::OrderStockOutHistory.create!(order_detail_id: order_detail_id, inventory_item_lot_stock_out: outstock_item)
  end

  def redirect_to_render_order_receipt
    redirect_to controller: 'pdf_renders', action: 'stock_receipts', order_ids: @succeed_allocate_order_ids
  end

  def find_orders!
    @orders = Order::Order.includes(order_details: :product).where(id: params[:order_ids])
  end
end
