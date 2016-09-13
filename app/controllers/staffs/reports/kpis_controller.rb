class Staffs::Reports::KpisController < ApplicationController
  def index
    @begin_date = params[:begin_date].blank? ? Date.today.beginning_of_month : Date.parse(params[:begin_date])
    @end_date = params[:end_date].blank? ? Date.today.end_of_month : Date.parse(params[:end_date])
    @orders = Order::Order.where(['order_orders.paid_approve_by_staff_id IS NOT ?', nil]).where(created_at: @begin_date..@end_date)

    respond_kpi_comission_report
  end

  private

  def respond_kpi_comission_report
    respond_to do |format|
      format.html { render 'index' }
    end
  end
end
