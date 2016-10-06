class Staffs::Warehouses::OrdersController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_orders!, only: [:show, :edit, :update]
  def index
    @orders = Order::Order.includes( order_details: :product).paid_full_orders.order(billing_id: :desc).page(params[:page]).per(params[:per_page])
  end

  def show
  end

  def new
  end

  def update
  end

  def destroy
  end

  private

  def find_orders!
    @order = Order::Order.find(params[:id])
  end
end
