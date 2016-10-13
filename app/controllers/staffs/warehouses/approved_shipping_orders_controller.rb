class Staffs::Warehouses::ApprovedShippingOrdersController < ApplicationController
  before_action :authenticate_staff!

  def index
    @orders = Order::Order.includes(order_details: [:product]).shipping_approved(current_staff.id).order(billing_id: :desc).page(params[:page]).per(params[:per_page])
  end
end
