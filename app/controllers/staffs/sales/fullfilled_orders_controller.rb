class Staffs::Sales::FullfilledOrdersController < ApplicationController
  before_action :authenticate_staff!
  around_action :skip_bullet, only: [:index, :search], if: -> { Rails.env.eql? 'development' }
  def index
    find_fullfilled_orders
  end

  def search
    if params[:search_key].blank?
      find_fullfilled_orders
    else
      search_orders
    end
    respond_to do |format|
      format.html { render 'index' }
    end
  end

  private

  def search_orders
    @orders =
      Order::Order.includes(order_details: [:product], shipping_address: [:freight_provider])
                  .search_by_full_name_or_billing_id(params[:search_key])
                  .fullfilled_orders_for_sale(current_staff.id)
                  .where('shipping_approve_by_staff_id IS NOT ?', nil)
                  .order(id: :desc)
                  .page(params[:page])
                  .per(params[:per_page])
  end

  def find_fullfilled_orders
    @orders =
      Order::Order.includes(order_details: [:product], shipping_address: [:freight_provider])
                  .fullfilled_orders_for_sale(current_staff.id)
                  .where('shipping_approve_by_staff_id IS NOT ?', nil)
                  .order(id: :desc)
                  .page(params[:page])
                  .per(params[:per_page])
  end
end
