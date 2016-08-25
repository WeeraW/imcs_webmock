class Staffs::Warehouses::ShippingAddressesController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_shipping_address!

  def update
    set_freight_info!
    redirect_to staffs_warehouses_approved_shipping_orders_path
  end

  private

  def set_freight_info!
    @shipping_address.freight_tracking_code = freight_tracking_code_params[:freight_tracking_code]
    @shipping_address.freight_provider_id = freight_tracking_code_params[:freight_provider_id]
    @shipping_address.save!
  end

  def redirect_or_render_on_save
    if @shipping_address.save!
      redirect_to staffs_warehouses_orders_path
    else
      redirect_to staffs_warehouses_orders_path, error: @shipping_address.errors.full_messages
    end
  end

  def find_shipping_address!
    @shipping_address = Fullfillment::ShippingAddress.find(params[:id])
  end

  def freight_tracking_code_params
    params.require(:fullfillment_shipping_address).permit(:freight_tracking_code, :freight_provider_id)
  end
end
