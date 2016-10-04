class Staffs::Accountings::SalerOrdersController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_order!

  def update
    @order.update(sale_order_params)
    byebug
    respond_on_update_success
  end

  private

  def respond_on_update_success
    respond_to do |format|
      format.html { redirect_back fallback_location: staffs_accountings_payments_path }
    end
  end

  def sale_order_params
    params.fetch(:order_order).permit(:sale_by_staff_id)
  end

  def find_order!
    @order = Order::Order.find(params[:id])
  end
end
