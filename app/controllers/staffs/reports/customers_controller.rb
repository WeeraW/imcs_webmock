class Staffs::Reports::CustomersController < ApplicationController
  before_action :authenticate_staff!
  def index
    @customers = Fullfillment::ShippingAddress.order(:id).page(params[:page]).per(params[:per])
  end

  def customers_list_report
    @customers = Fullfillment::ShippingAddress.order(:id)

    respond_to do |format|
      format.xlsx { render xlsx: 'customers_list_report' }
    end
  end
end
