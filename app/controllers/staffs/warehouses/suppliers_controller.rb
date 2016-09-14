class Staffs::Warehouses::SuppliersController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_suppliers!, only: [:show, :edit, :update]
  def index
    @suppliers = Supplier::Supplier.where(['id <> ?', 0]).page(params[:page]).per(params[:per_page])
  end

  def show
  end

  def new
    @supplier = Supplier::Supplier.new
  end

  def create
    @supplier = Supplier::Supplier.new(supplier_params)
    render_or_redirect_to_index_after_save
  end

  def update
  end

  def destroy
  end

  private

  def find_suppliers!
    @supplier = Supplier::Supplier.find(params[:id])
  end

  def supplier_params
    params.fetch(:supplier_supplier).permit(:tax_id, :display_name, :company_code, :address, :postal_code)
  end

  def render_or_redirect_to_index_after_save
    if @supplier.save
      respond_to do |format|
        format.html { redirect_to staffs_warehouses_suppliers_path }
      end
    else
      render 'new'
    end
  end
end
