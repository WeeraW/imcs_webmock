class Staffs::Accountings::PaymentsController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_payment!, only: [:edit, :show, :update]
  def index
    @payments = Payment::Detail.includes(order: [{ order_details: :product }]).pending_payments.order('order_orders.billing_id ASC').page(params[:page]).per(params[:per_page])
  end

  def new; end

  def create; end

  def edit; end

  def update
    set_reconciled_payment
    set_payment_approver
    approve_order_if_paid_full
    render_or_redirect_on_save
  end

  private

  def approve_order_if_paid_full
    return if @payment.order.total_price - @payment.order.total_paid_reconciled > 0
    @payment.order.paid_approve_by = current_staff
    @payment.order.paid_full_date = DateTime.now
    @payment.order.save!
  end

  def set_reconciled_payment
    @payment.update(payment_reconcile_params)
  end

  def set_payment_approver
    @payment.approve current_staff
  end

  def render_or_redirect_on_save
    if @payment.save
      respond_to do |format|
        format.html { redirect_to staffs_accountings_payments_path }
      end
    else
      render 'index'
    end
  end

  def find_payment!
    @payment = Payment::Detail.find(params[:id])
  end

  def payment_reconcile_params
    params.fetch(:payment_detail).permit(:pay_amount_reconciled)
  end
end
