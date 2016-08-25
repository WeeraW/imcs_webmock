class Staffs::Sales::FullfilledOrdersController < ApplicationController
  before_action :authenticate_staff!
  around_action :skip_bullet, only: [:index]
  def index
    @orders = Order::Order.fullfilled_orders_for_sale(current_staff.id).page(params[:page]).per(params[:per_page])
  end
end
