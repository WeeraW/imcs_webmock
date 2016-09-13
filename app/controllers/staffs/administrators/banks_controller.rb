class Staffs::Administrators::BanksController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_bank!, only: [:edit, :update]

  def index
    @banks = Accounting::Bank.where(['id <> ?', 0]).page(params[:page]).per(params[:per_page])
  end

  def new
    @bank = Accounting::Bank.new
  end

  def create
    @bank = Accounting::Bank.new(bank_params)
    render_or_redirect_to_index_on_save 'new'
  end

  def update
    @bank.update(bank_params)
    render_or_redirect_to_index_on_save 'edit'
  end

  def edit; end

  private

  def render_or_redirect_to_index_on_save(template)
    if @bank.save
      respond_to do |format|
        format.html { redirect_to staffs_administrators_banks_path }
      end
    else
      render template
    end
  end

  def bank_params
    params.fetch(:accounting_bank).permit(:code, :display_name)
  end

  def find_bank!
    @bank = Accounting::Bank.find(params[:id])
  end
end
