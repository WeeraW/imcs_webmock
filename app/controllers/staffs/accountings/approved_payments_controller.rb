class Staffs::Accountings::ApprovedPaymentsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @payments = Payment::Detail.includes(order: [{ order_details: :product }]).payments_approved_by(current_staff).page(params[:page]).per(params[:per_page])
  end
end
