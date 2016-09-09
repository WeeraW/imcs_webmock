class Staffs::Reports::StaffCommissionsController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_paid_orders_in_date_range!, only: [:index]
  def index
  end

  private

  def find_paid_orders_in_date_range!
    @begin_date = params[:begin_date].blank? ? Date.today.beginning_of_month : Date.parse(params[:begin_date])
    @end_date = params[:end_date].blank? ? Date.today.end_of_month : Date.parse(params[:end_date])
    @staff_orders = Staff.joins(:created_orders).group(:id).where(['order_orders.paid_approve_by_staff_id IS NOT ?', nil]).where(created_at: @begin_date..@end_date).page(params[:page]).per(params[:per_page])

    respond_staff_comission_report
  end

  def respond_staff_comission_report
    respond_to do |format|
      format.html { render 'index' }
    end
  end
end
