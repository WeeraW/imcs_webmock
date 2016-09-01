class Staffs::Sales::PaymentsController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_order!
  # around_action :set_payment_time_zone_to_th
  def index
    # includes(company_bank_account: [:bank])
    @payments = @order.payment_details.includes(company_bank_account: { bank_branch: :bank }).page(params[:page]).per(params[:per_page])
  end

  def new
    @payment = @order.payment_details.new
  end

  def create
    @payment = @order.payment_details.new(payment_params)
    set_payment_time_zone_to_th

    set_create_by
    render_or_redirect_on_save
  end

  def edit; end

  def update; end

  private
  # FIXME: May cause bug in future
  def set_payment_time_zone_to_th
    @payment.pay_datetime = @payment.pay_datetime.to_s.sub(/UTC/, '+0700')
  end

  def set_create_by
    @payment.create_by = current_staff
  end

  def render_or_redirect_on_save
    if @payment.save
      respond_to do |format|
        format.html { redirect_to staffs_sales_order_payments_path(@order) }
      end
    else
      render 'new'
    end
  end

  def find_order!
    @order = Order::Order.find(params[:order_id])
  end

  def payment_params
    params.fetch(:payment_detail).permit(:pay_amount, :pay_datetime, :note, :accounting_company_bank_account_id, :payment_receipt_image_file)
  end
end
