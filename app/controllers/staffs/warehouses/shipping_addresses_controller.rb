class Staffs::Warehouses::ShippingAddressesController < ApplicationController
  before_action :authenticate_staff!

  def update

  end

  private

  def set_freight_info
    @shipping_addresses.
  end

  def redirect_or_render_on_save
    if @shipping_addresses.save!
      redirect_to staffs_warehouses_orders_path
    else
      redirect_to staffs_warehouses_orders_path, error: @shipping_addresses.errors.full_messages
    end
  end

  def find_shipping_address!
    @shipping_addresses = Fullfillment::ShippingAddress.find(params[:id])
  end

  def freight_tracking_code_params
    params.require(:fullfillment_shipping_address).permit(:freight_tracking_code, :freight_provider_id)
  end
end
