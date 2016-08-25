class Staffs::Warehouses::ApprovedShippingOrdersController < ApplicationController
  before_action :authenticate_staff!

  def index
    @orders = Order::Order.shipping_approved(current_staff.id).page(params[:page]).per(params[:per_page])
  end
end
