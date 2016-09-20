class Staffs::Sales::CreateOrdersController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_orders, only: [:edit, :update]
  def new
    @order = Order::Order.new
    @order.order_details.new
    @order.payment_details.new
    @order.shipping_address = Fullfillment::ShippingAddress.new
  end

  def create
    @order = Order::Order.new(order_params)
    create_shipping_address
    set_payment_create_by
    set_create_by
    render_or_redirect_save
  end

  def edit; end

  def update
    @order.update(order_params)
    render_or_redirect_on_save
  end

  private

  def set_payment_create_by
    @order.payment_details.first.create_by = current_staff
  end

  def create_shipping_address
    @order.shipping_address = Fullfillment::ShippingAddress.new address_params[:shipping_address_attributes]
  end

  def render_or_redirect_save
    if @order.save
      respond_to do |format|
        format.html { redirect_to staffs_sales_orders_path }
      end
    else
      render 'new'
    end
  end

  def order_save
    @order.save
  end

  def find_orders!
    @order = Order::Order.find(params[:id])
  end

  def set_create_by
    @order.create_by = current_staff
  end

  def order_params
    params.fetch(:order_order).permit(
      :sale_by_staff_id,
      order_details_attributes: [:product_product_id, :quantity, :_destroy],
      payment_details_attributes: [:pay_amount, :pay_datetime, :payment_detail_from_bank_id, :from_bank_id, :accounting_company_bank_account_id, :payment_receipt_image_file, :note]
    )
  end

  def address_params
    params.fetch(:order_order).permit(shipping_address_attributes: [:recipient_name, :recipient_telephone_number, :address, :district, :city, :state, :postal_code])
  end
end
