class Staffs::Warehouses::PdfRendersController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_orders!, only: [:address_labels, :stock_receipts]
  def address_labels
    respond_if_print_address
  end

  def stock_receipts
    respond_if_print_stock_receipt
  end

  private

  def find_orders!
    @orders = Order::Order.includes(order_details: :product).where(id: params[:order_ids])
  end

  def respond_if_print_stock_receipt
    respond_to do |format|
      format.pdf do
        render template: 'staffs/shared/pdf_forms/stock_recipe_forms',
               layout: 'pdf',
               pdf: 'stock_receipts',
               page_size: 'A4',
               encoding: 'UTF-8',
              #  show_as_html: true,
               margin: {
                 top: '0.5in',
                 bottom: '0.5in',
                 left: '0.5in',
                 right: '0.5in'
               }
      end
    end
  end

  def respond_if_print_address
    respond_to do |format|
      format.pdf do
        render template: 'staffs/warehouses/pdf_renders/address_labels',
               layout: 'pdf',
               pdf: 'labels',
               page_width: '95mm',
               page_height: '60mm',
               encoding: 'UTF-8',
               margin: {
                 top: '0.15in',
                 bottom: '0.1in',
                 left: '0.05in',
                 right: '0.05in'
               }
      end
    end
  end
end
