class Staffs::Warehouses::OrdersController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_order!, only: [:edit, :update]
  def index
    find_paid_orders!
  end

  def update; end

  def destroy; end

  def search
    if params[:search_key].blank?
      find_paid_orders!
    else
      search_orders!
    end

    respond_to do |format|
      format.html { render 'index' }
    end
  end

  private

  def search_orders!
    @orders =
      Order::Order.search_by_full_name(params[:search_key])
                  .where('order_orders.shipping_approve_by_staff_id IS ? AND order_orders.paid_approve_by_staff_id IS NOT ?', nil, nil)
                  .page(params[:page])
                  .per(params[:per_page])
  end

  def find_paid_orders!
    @orders = Order::Order.includes(order_details: :product).paid_full_orders.order(billing_id: :desc).page(params[:page]).per(params[:per_page])
  end

  def find_order!
    @order = Order::Order.find(params[:id])
  end
end
