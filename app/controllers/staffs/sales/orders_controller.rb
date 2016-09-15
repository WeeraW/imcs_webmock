class Staffs::Sales::OrdersController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_orders!, only: [:show, :edit, :update]
  def index
    @orders = Order::Order.includes(order_details: [:product]).where(create_by: current_staff, shipping_approve_by: nil).page(params[:page]).per(params[:per_page])
  end

  def show; end

  def new
    @order = Order::Order.new
    @order.order_details.new
    @order.shipping_address = Fullfillment::ShippingAddress.new
    # @order.build_act_as_shippingable.build_fullfillment_shipping_address
  end

  def create
    @order = Order::Order.new(order_params)
    create_shipping_address
    set_create_by
    render_or_redirect_save
  end

  def edit; end

  def update
    @order.update(order_params)
    render_or_redirect_on_save
  end

  def destroy; end

  private

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
    params.fetch(:order_order).permit(order_details_attributes: [:product_product_id, :quantity, :_destroy])
  end

  def address_params
    params.fetch(:order_order).permit(shipping_address_attributes: [:recipient_name, :recipient_telephone_number, :address, :district, :city, :state, :postal_code])
  end
end
