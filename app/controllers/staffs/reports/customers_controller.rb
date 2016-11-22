class Staffs::Reports::CustomersController < ApplicationController
  before_action :authenticate_staff!
  def index
    @orders = Order::Order.order(:id).page(params[:page]).per(params[:per])
  end

  def customers_list_report
    @orders = Order::Order.includes(:shipping_address, order_details: [:product]).shipped.order(:id)

    respond_to do |format|
      format.xlsx { render xlsx: 'customers_list_report' }
    end
  end
end
